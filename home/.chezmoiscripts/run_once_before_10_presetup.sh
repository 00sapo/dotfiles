#!/bin/sh
# vim: ft=sh

echo install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

echo install tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo setup ssh sockets
mkdir -p ~/.ssh/sockets

echo install appman:
echo curl https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER | sh
echo
