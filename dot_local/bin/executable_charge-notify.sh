#! /bin/bash
#
# Script to notify when battery is outside levels - time to plug charger.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.#
#
# Source: https://linoxide.com/remind-unplug-charging-laptop-arch-linux
#
# @linux-aarhus - root.nix.dk
#
# 2021-11-27
# 2021-11-28 revised - checks not updating
#                    - fix variable check on all levels
# 2023-03-14         - added sound option

### SETTINGS
# check interval (seconds)
INTERVAL=60

# example battery levels
# these levels are not based on scientific evidence
# you are required to adjust as appropriate for your device and research
MIN_BAT=30     # low water mark
MAX_BAT=60     # high water mark

POWER_UNPLUG=/usr/share/sounds/freedesktop/stereo/power-unplug.oga
POWER_PLUG=/usr/share/sounds/freedesktop/stereo/power-plug.oga

### /END SETTINGS

set -eu

# dependency check
if ! [[ "$(which notify-send)" =~ (notify-send) ]]; then
    echo "Please install libnotify to use this script.\n"
    echo "   sudo pacman -S libnotify"
    exit 1
fi
if ! [[ "$(which acpi)" =~ (acpi) ]]; then
    echo "Please install acpi to use this script.\n"
    echo "   sudo pacman -S acpi"
    exit 1
fi

get_plugged_state(){
    echo $(cat /sys/bus/acpi/drivers/battery/*/power_supply/BAT?/status)
}

get_bat_percent(){
    echo $(acpi|grep -Po "[0-9]+(?=%)"|tail -n 1)
}

notify_sound(){
    if [[ -n $1 ]]; then
        paplay ${1}
    fi
}

# primary loop
while true ; do
    echo "Current battery: $(get_bat_percent)"
    echo "Current state: $(get_plugged_state)"
    if [ $(get_bat_percent) -le ${MIN_BAT} ]; then # Battery under low limit
        if [[ $(get_plugged_state) = "Discharging" ]]; then # plugged
            notify-send "Battery below ${MIN_BAT}. Time to plug adapter"
            notify_sound $POWER_PLUG
        fi
    fi
    if [ $(get_bat_percent) -ge ${MAX_BAT} ]; then # Battery over high limit
        if [[ $(get_plugged_state) = "Charging" ]]; then # plugged
            notify-send "Battery above ${MAX_BAT}. Time to unplug adapter"
            notify_sound $POWER_UNPLUG
        fi
    fi

    sleep ${INTERVAL} # Repeat every $INTERVAL seconds
done
