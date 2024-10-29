# Installation

1. run: `mkdir -p ~/.ssh/sockets`
2. execute:

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply 00sapo
sudo apt install fish
fc-cache
chsh
```

3. Now, re-login. If on a desktop, continue with:

```
curl -fsSL https://get.jetify.com/devbox | bash
devbox install
setup-my-keys # this maybe doesn't work
```

4. install remaining system packages (see below)
5. reboot

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
9. pipewire-audio
10. Jack and pipewire-jack (see further configuration on Debian wiki)
11. python build dependencies

### Music software

This software is installed in the base system for performance reasons.

1. din is noise
2. surge-xt (from .deb file)
3. zynaddsubfx
4. calf-plugins
5. BespokeSynth
6. Ardour

### Packages that should be migrated somewhere else

1. btrfs-assistant (from OBS repos)

### Other notes

#### Evolution

Evolution login in Debian stable is not working for Microsoft, so I'm taking it from devbox.
