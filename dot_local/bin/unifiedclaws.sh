#!/bin/env bash
# Simple script which takes a path to an mbox file ($1)
# and creates a symbolic link into a second mbox mail directory $2
# e.g.
# - if $1 is /some/path/mail-name/dir/file,
#   then the link will be $2/Dir/some_path_mail-name_dir_file
# - if $1 is /some/path/mail-name/sub/DIRS/file,
#   then the link will be $2/Dirs/num
# So only the last subdir will be used and it will be put into lower case
# The filename `num` will be created by taking the last num in the destination
# dir and summing 1

# Convert $1 and $2 to absolute paths
abs_path1=$(realpath -s "$1")
abs_path2=$(realpath -s "$2")
# if abs_path1 starts with abs_path1
if [[ $abs_path1 == $abs_path2* ]]; then
  echo "skipping mail in $2"
  exit 0
fi

# take the subdir
parent_dir="$(basename "$(dirname "$1")")"
# put in lower case
parent_dir="$(echo "$parent_dir" | sed 's/\(.*\)/\L\1/')"
# echo "Linking \"$1\" to \"$2/$parent_dir/$dest_name\""
# Create the parent directory if it does not exist
mkdir -p "$2/$parent_dir"
# check if in the destination dir there is a file pointing to $1
if find "$2/$parent_dir" -maxdepth 1 -type l -lname "$1" | grep -q .; then
  echo "$1 already linked in $2/$parent_dir"
  exit 0
fi

# take a lock to count the existing emails
lockfile="/tmp/unifiedclaws.lock"
exec 200>"$lockfile"
flock -n 200 || exit 1
# get the last number in the destination dir
num="$(find "$2/$parent_dir" -maxdepth 1 \( -type f -o -type l \) -not -path '*/.*' -printf '%f\n' | grep -o '[0-9]*$' | sort -n | tail -n 1)"
num="${num:-0}"
# release the lock
flock -u 200

num="${num:-0}"
# create the new filename
dest_name="$((num + 1))"
# link
echo "linking $1 to $2/$parent_dir/$dest_name"
ln -s "$1" "$2/$parent_dir/$dest_name"
