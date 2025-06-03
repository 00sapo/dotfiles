#!/bin/sh
# vim: ft=sh

echo install soar
curl -fsSL https://soar.qaidvoid.dev/install.sh | sh
# adding cargo-bins repository to soar (needed for rbw)
mkdir -pv "$HOME/.config/soar" &&
  tee -a "$HOME/.config/soar/config.toml" <<EOF
[[repositories]]
name = "cargo-bins"
url = "https://meta.pkgforge.dev/external/cargo-bins/x86_64-Linux.json.zstd"
EOF

echo install rbw
soar sync
soar install rbw
# fix rbw-agent (it's missing in the cargo-bins repo)
ln -s "$HOME"/.local/share/soar/packages/rbw-cargo-bins.*/rbw-agent "$HOME"/.local/share/soar/bin/rbw-agent
# removing cargo-bins repository from soar (avoid conflicts with chezmoi configs)
rm -f "$HOME/.config/soar/config.toml"

echo setup ssh key
"$HOME"/.local/share/soar/bin/rbw config set email $(echo "feder" "icosi" "mon" "ett" "a+" "bitwarden" "@" "zoh" "o.com" | sed 's/ //g')
"$HOME"/.local/share/soar/bin/rbw config set pinentry pinentry-curses
"$HOME"/.local/share/soar/bin/rbw login
mkdir .ssh
"$HOME"/.local/share/soar/bin/rbw get Claude >.ssh/id_rsa
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
