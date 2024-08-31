#!/bin/sh
OPENRGB="openrgb"
IDLETIME=10000 # 30 seconds
ACTIVE_OPTIONS='-m Static -b 20 -c FFFFFF'

# get the active mode from $OPENRGB -l
active_mode() {
  cat ~/.cache/openrgb_state | cut -d' ' -f2
}

active_state() {
  cat ~/.cache/openrgb_state | cut -d' ' -f1
}

# if the file doesn't exist, create it
if [ ! -f ~/.cache/openrgb_state ]; then
  echo "1" >~/.cache/openrgb_state
fi

# toggle state
# 1 = active
# 0 = inactive
# compare strings
if [ "$(active_state)" = "0" ]; then
  echo "1 on" >~/.cache/openrgb_state
  $OPENRGB $ACTIVE_OPTIONS
else
  echo "0 off" >~/.cache/openrgb_state
  $OPENRGB -m "Off"
fi

active_state=$(active_state)
while [ "$active_state" = "1" ]; do
  # if X11, use xprintidle
  if [ -n "$DISPLAY" ]; then
    # xprintidle for X11 systems
    idle=$(xprintidle)
  else
    # dbus for wayland
    idle=$(dbus-send --print-reply --dest=org.gnome.Mutter.IdleMonitor /org/gnome/Mutter/IdleMonitor/Core org.gnome.Mutter.IdleMonitor.GetIdletime | awk '/uint64/{print $2}')
  fi
  if [ "$idle" -gt $IDLETIME ]; then
    if [ "$(active_mode)" = "on" ]; then
      $OPENRGB -m "Off"
      echo "1 off" >~/.cache/openrgb_state
    fi
  else
    if [ "$(active_mode)" = "off" ]; then
      $OPENRGB $ACTIVE_OPTIONS
      echo "1 on" >~/.cache/openrgb_state
    fi
  fi
  sleep 0.5
  active_state=$(active_state) # exits when this script is called again
done
