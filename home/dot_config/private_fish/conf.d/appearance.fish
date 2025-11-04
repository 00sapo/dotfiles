function update_theme --on-variable OS_APPEARANCE
  echo
  echo "🖕OS theme changed!"
  if string match $OS_APPEARANCE "dark" >/dev/null
    echo "󱢇 Setting dark Fish theme!"
    yes | fish_config theme save "Mono Smoke"
    if test -f $HOME/.config/lazygit/config.yml.dark
      cp $HOME/.config/lazygit/config.yml.dark $HOME/.config/lazygit/config.yml
    end
  else
    echo "󱢇 Setting light Fish theme!"
    yes | fish_config theme save "Mono Lace"
    if test -f $HOME/.config/lazygit/config.yml.light
      cp $HOME/.config/lazygit/config.yml.light $HOME/.config/lazygit/config.yml
    end
  end
end
