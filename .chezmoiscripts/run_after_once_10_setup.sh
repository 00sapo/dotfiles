#!/bin/sh

if command -v fish >/dev/null; then
  echo install fish plugins
  cat $HOME/.config/fish/fish_plugins | xargs fisher install
fi
