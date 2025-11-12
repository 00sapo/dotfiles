function update_theme --on-variable OS_APPEARANCE
  echo
  echo "🖕OS theme changed!"

  set -x TASKRC "$HOME/.config/task/taskrc"
  if string match $OS_APPEARANCE "dark" >/dev/null
    echo "󱢇 Setting dark Fish theme!"
    yes | fish_config theme save "Mono Smoke"
    if test -f $HOME/.config/lazygit/config.yml.dark
      cp $HOME/.config/lazygit/config.yml.dark $HOME/.config/lazygit/config.yml
    end
    # Configure taskwarrior for dark theme
    if test -f $TASKRC
      sed -i 's/^include light-256.theme/#include light-256.theme/' $TASKRC
      sed -i 's/^#include dark-violets-256.theme/include dark-violets-256.theme/' $TASKRC
    end
  else
    echo "󱢇 Setting light Fish theme!"
    yes | fish_config theme save "Mono Lace"
    if test -f $HOME/.config/lazygit/config.yml.light
      cp $HOME/.config/lazygit/config.yml.light $HOME/.config/lazygit/config.yml
    end
    # Configure taskwarrior for light theme
    if test -f $TASKRC
      sed -i 's/^include dark-violets-256.theme/#include dark-violets-256.theme/' $TASKRC
      sed -i 's/^#include light-256.theme/include light-256.theme/' $TASKRC
    end
  end
end
