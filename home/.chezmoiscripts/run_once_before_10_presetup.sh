#!/bin/sh
# vim: ft=sh

# installing appman
echo 2 | wget -qO- https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER | sh

# installing rbw
appman -i rbw
rbw config set email $(echo 'ZmVkMzvCtGUzJCAycmkpUDJjb3NpICFdMG0wKC1vbmV0MiM0dGExMzQrRFZiaXR3MiRePmFyOUsyZGVuUyTCqEB6MG9oJW8uY29tCg==' | base64 -d | sed 's/[^a-z@.+]//g')
rbw config set pinentry pinentry-curses
rbw login

# setup ssh key
mkdir .ssh
rbw get Claude >.ssh/id_rsa
chmod 0400 .ssh/id_rsa

echo install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

echo install tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo setup ssh sockets
mkdir -p ~/.ssh/sockets

echo import GPG keys
rbw get "GPG-PUBLIC" | gpg --batch --import
rbw get "GPG-PRIVATE" | gpg --batch --import
