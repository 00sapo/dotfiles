# Installation

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply 00sapo
```

## System config

It's also useful to check suspend mechanism.

- `cat /sys/power/mem_sleep`: if [s2idle] is selected, the suspend state is fast but not very saving energy, Better putting deep: add `mem_sleep_default=deep` as a kernel parameter to the `/etc/default/grub` file and run `sudo grub-mkconfig -o /boot/grub/grub.cfg`.
- for host named `cucchia`, the above rule is already setup by `rootmoi` (see `root/etc/default/grub.tmpl`).

## Packages

### Debian

See `$HOME/debianbase.install` for a list of packages installed after a minimal installation.

In general:

- a DE (plasma-desktop, sddm)
- a terminal emulator (wezterm)
- a browser (brave)
- document utilities (okular, libreoffice, evolution)
- any other tool: fish, nvim, apt, tlp, zram-tools, zoxide, ripgrep, openrgb, lsyncd, curl, earlyoom, etc.

### Appman

Install from `$HOME/am.install`:
> `cat $HOME/am.install | xargs appman -i`

### asdf

- Use the following

```fish
for tool in "python golang nodejs rust delta lazygit"
  asdf plugin-add $tool
  asdf install $tool latest
end
```

## Other notes

#### Trixie

Trixie will include git-delta (currently using asdf).

#### Evolution

Evolution login in Debian stable is not working for Microsoft, so you need to use an updated version
to login (e.g. via flatpak or distrobox), then you can use Debian's version.
