#!/bin/sh

if command -v fc-cache >/dev/null 2>&1; then
  echo "Font cache tool found."
else
  echo "Font cache tool not found. Please install fontconfig."
  exit 1
fi
echo "Updating font-cache..."
fc-cache
