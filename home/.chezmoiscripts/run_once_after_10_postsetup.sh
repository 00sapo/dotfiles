#!/bin/sh

if command -v fish >/dev/null; then
  echo install fish plugins
  if test -f "$HOME/.config/fish/fish_plugins"; then
    for plugin in $(cat "$HOME/.config/fish/fish_plugins"); do
      fish -c "fisher install '$plugin'"
    done
  else
    echo "$HOME/.config/fish/fish_plugins not found!"
  fi
fi

# change chezmoi source to ssh
curdir=$(pwd)
cd $HOME/.local/share/chezmoi
git remote set-url origin git@github.com:00sapo/dotfiles.git
git pull
cd $curdir
