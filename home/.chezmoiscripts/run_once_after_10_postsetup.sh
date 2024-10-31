#!/bin/sh

if command -v fish >/dev/null; then
  echo install fish plugins
  for plugin in $(cat "$HOME/.config/fish/fish_plugins"); do
    fish -c "fisher install '$plugin'"
  done
fi
