#!/bin/sh
# vim: ft=sh

echo installing stew
if command -v dpkg >/dev/null 2>&1; then
  arch=$(dpkg --print-architecture)
else
  arch=$(uname -m)
fi
curl -s https://api.github.com/repos/marwanhawari/stew/releases/latest |
  grep -E "https://.*/stew-.*-linux-amd64.tar.gz" |
  cut -d : -f 2,3 |
  tr -d \" |
  wget -qi -
tar -xf stew*.tar.gz
mv stew ~/.local/bin
rm stew*

echo installing from stew applications from lock file
export PATH="$HOME/.local/bin:$PATH"
stew install "$(dirname 0)/../dot_config/stew/Stewfile.lock.json"

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
