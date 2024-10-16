#!/bin/env bash

# array of remote names; mega with 2FA is not supported
remotes=(laudare dropbox koofr)

# array of local paths
locals=($HOME/Rclone/laudare $HOME/Rclone/dropbox $HOME/Rclone/koofr)

if [[ -e /run/.containerenv || -e /.dockerenv ]]; then
  # we are inside a container
  echo "We are inside a container. Exiting."
  exit 1
fi

# command for retrieving rclone password
if [[ $(command -v rbw) ]]; then
  cmd="rbw get rclone"
elif [[ $(command -v kwallet-query) ]]; then
  cmd="kwallet-query -r rclone-config kdewallet"
elif [[ $(command -v secret-tool) ]]; then
  # note, secret-tool is installed by homebrew as a dependency of poppler and of some
  # other packages
  cmd="secret-tool lookup rclone config"
fi
if [[ -z $cmd ]]; then
  echo "No password command found. Exiting."
  exit 1
fi

create_backup() {
  # create a backup of a directory if not empty and merge with existing backups
  if [ -d "$1" ]; then
    if [ -d "$1.bak" ]; then
      rsync -a --delete "$1/" "$1.bak/"
    else
      cp -r "$1" "$1.bak"
    fi
  fi
}

_mount() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  else
    create_backup "$1"
  fi
  parent=$(dirname "$1")
  nohup rclone mount --password-command="$cmd" \
    --vfs-cache-mode full \
    --vfs-cache-max-size 2G \
    --vfs-cache-max-age 720h \
    --vfs-write-back 1s \
    --log-level INFO \
    "$2": "$1" >$parent/$2.log 2>&1 &
  # get the output of the last command (if it failed, print an error message)
  sleep 5
  if [ $? -eq 0 ]; then
    echo "Mounted $2 to $1"
    rsync -a "$1.bak/" "$1/"
    if [ $? -eq 0 ]; then
      echo "Successfully merged $1.bak to $1"
    else
      echo "!!! Failed to merge $1.bak to $1 !!!"
    fi
  else
    echo "!!! Failed to mount $2 to $1 !!!"
  fi
}

existing_mounts=$(mount | grep fuse.rclone)
# create mount points if they don't exist and mount
# if some argument is give, mount only the remote passed as $1
# otherwise, mount all remotes
if [ $# -eq 1 ]; then
  for ((i = 0; i < ${#remotes[@]}; ++i)); do
    if [ "$1" = "${remotes[$i]}" ]; then
      loc=${locals[$i]}
      rem=${remotes[$i]}
      _mount "$loc" "$rem"
      exit 0
    fi
  done
  echo "Remote $1 not found"
  exit 1
elif [ $# -eq 0 ]; then
  for ((i = 0; i < ${#remotes[@]}; ++i)); do
    loc=${locals[$i]}
    rem=${remotes[$i]}
    # if the remote is already mounted, skip it
    if echo "$existing_mounts" | grep -q "$loc"; then
      echo "$rem is already mounted to $loc"
      continue
    fi
    _mount "$loc" "$rem"
  done
else
  echo "Usage: rclone-mounts [remote]"
  exit 1
fi
