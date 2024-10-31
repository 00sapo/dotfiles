#!/bin/sh
# vim: ft=sh

# 1. install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# 2. install appman
curl https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER | sh

# 3. setup ssh sockets
mkdir -p ~/.ssh/sockets
