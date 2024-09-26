#!/bin/env bash

# array of remote names; mega with 2FA is not supported
remotes=(laudare dropbox koofr)

# array of local paths
locals=($HOME/Rclone/ateneopv $HOME/Rclone/laudare $HOME/Rclone/dropbox $HOME/Rclone/koofr)

if [[ -e /run/.containerenv || -e /.dockerenv ]]; then
  # we are inside a container
  echo "We are inside a container. Exiting."
  exit 1
fi

# command for retrieving rclone password
if [[ $(command -v kwallet-query) ]]; then
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

existing_mounts=$(mount | grep fuse.rclone)
# create mount points if they don't exist and mount
for ((i = 0; i < ${#remotes[@]}; ++i)); do
  # if the remote is already mounted, skip it
  if echo "$existing_mounts" | grep -q "${locals[$i]}"; then
    echo "${remotes[$i]} is already mounted to ${locals[$i]}"
    continue
  fi
  if [ ! -d "${locals[$i]}" ]; then
    mkdir -p "${locals[$i]}"
  else
    create_backup "${locals[$i]}"
  fi
  parent=$(dirname "${locals[$i]}")
  nohup rclone mount --password-command="$cmd" \
    --vfs-cache-mode full \
    --vfs-cache-max-size 2G \
    --vfs-cache-max-age 720h \
    --vfs-write-back 1s \
    --log-level INFO \
    "${remotes[$i]}": "${locals[$i]}" >$parent/${remotes[$i]}.log 2>&1 &
  # get the output of the last command (if it failed, print an error message)
  sleep 5
  if [ $? -eq 0 ]; then
    echo "Mounted ${remotes[$i]} to ${locals[$i]}"
    rsync -a "${locals[$i]}.bak/" "${locals[$i]}/"
    if [ $? -eq 0 ]; then
      echo "Successfully merged ${locals[$i]}.bak to ${locals[$i]}"
    else
      echo "!!! Failed to merge ${locals[$i]}.bak to ${locals[$i]} !!!"
    fi
  else
    echo "!!! Failed to mount ${remotes[$i]} to ${locals[$i]} !!!"
  fi
done
