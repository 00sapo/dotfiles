if status is-interactive
    # Set up vim mode
    set -g fish_key_bindings fish_vi_key_bindings
    bind -M insert \cc kill-whole-line repaint
    bind -M insert -k nul accept-autosuggestion
    bind -M insert \eL __fish_list_current_token # alt-l (\el) is used in tmux/nvim for resizing

    # zoxide
    command -v zoxide >/dev/null; and zoxide init fish | source

    # start ssh-agent
    fish_ssh_agent

    # pyenv
    command -v pyenv >/dev/null; and SHELL=(which fish) pyenv init - | source

    command -v thefuck >/dev/null; and thefuck --alias | source

    command -v cbonsai >/dev/null; and cbonsai --base (random 1 2) --life (random 10 80) --multiplier (random 2 18) --message (fortune -as)

end
