# Installation

1. run: `mkdir -p ~/.ssh/sockets`
2. execute:

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply 00sapo
sudo apt install fish
fc-cache
chsh
```

5. Now, re-login. If on a desktop, continue with:

```
sudo apt install flatpak
xargs flatpak install < flatpak.install
setup-my-keys # this maybe doesn't work
```

6. Install the brew packages (neovim and git-delta will be ok in Trixie):

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install neovim git-delta lazygit
```

6. install remaining system packages (see below)
7. reboot

## System config

It's also useful to check suspend mechanism.

- `cat /sys/power/mem_sleep`: if [s2idle] is selected, the suspend state is fast but not very saving energy, Better putting deep: add `mem_sleep_default=deep` as a kernel parameter to the `/etc/default/grub` file and run `sudo grub-mkconfig -o /boot/grub/grub.cfg`.

## Packages that need to be installed in the main system

1. kde-plasma-desktop
2. pkexec
3. nvidia-detect
4. nvidia-driver
5. mesa-utils
6. tlp
7. zram-tools
8. grub-btrfs (from Kali repos)
9. flatpak
10. pipewire-audio
11. Jack and pipewire-jack (see further configuration on Debian wiki)
12. python build dependencies

### Music software

This software is installed in the base system for performance reasons.

1. din is noise
2. surge-xt (from .deb file)
3. zynaddsubfx
4. calf-plugins
5. BespokeSynth
6. Ardour

### Packages that should be migrated to appimage/flatpaks

1. btrfs-assistant (from OBS repos)
2. megasync (flatpak version freezes when syncing, needs the sources apt list)

### Other notes

#### Evolution

Evolution flatpak is a mess.
The debian one easily remains behin third-party provider changes (microsoft, google, etc.)
Right now archlinux distrobox is the best option, but needs some dbus files installed in the base system: `apt
install evolution-data-server`.
Moreover, archlinux also provides evolution-on for the system-tray icon.

```

```
