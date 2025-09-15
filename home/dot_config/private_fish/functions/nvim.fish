function nvim
    set nvim_bin (which nvim 2>/dev/null)
    rbw unlock

    $nvim_bin $argv
end
