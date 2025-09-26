# Installation

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply 00sapo
```

## System config

It's also useful to check suspend mechanism.

- `cat /sys/power/mem_sleep`: if [s2idle] is selected, the suspend state is fast but not very saving energy, Better putting deep: add `mem_sleep_default=deep` as a kernel parameter to the `/etc/default/grub` file and run `sudo grub-mkconfig -o /boot/grub/grub.cfg`.
- for host named `cucchia`, the above rule is already setup by `rootmoi` (see `root/etc/default/grub.tmpl`).

### asdf

- Use the following

```fish
for tool in "python golang nodejs rust"
  asdf plugin-add $tool
  asdf install $tool latest
end
```
