#!/bin/sh
# vim: ft=sh

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# install appman
curl https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER | sh

# install tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# setup ssh sockets
mkdir -p ~/.ssh/sockets
