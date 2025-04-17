#!/bin/sh
# vim: ft=sh

echo install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

echo install tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo setup ssh sockets
mkdir -p ~/.ssh/sockets

echo import GPG keys
rbw get "GPG-PUBLIC" | gpg --batch --import
rbw get "GPG-PRIVATE" | gpg --batch --import
