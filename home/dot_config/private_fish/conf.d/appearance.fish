set CURRENT_APPEARANCE $OS_APPEARANCE # used to check if theme is changed

function __change_theme
  if string match $CURRENT_APPEARANCE "dark"
    echo "󱢇 Setting dark Fish theme!"
    yes | fish_config theme save "Mono Smoke"
  else
    echo "󱢇 Setting light Fish theme!"
    yes | fish_config theme save "Mono Lace"
  end
end

function update_theme --on-event fish_prompt
  if [ $CURRENT_APPEARANCE != $OS_APPEARANCE ]
    echo
    echo "🖕OS theme changed!"
    set CURRENT_APPEARANCE $OS_APPEARANCE
    __change_theme
  end
end
