function nvim
    set nvim_bin (which nvim 2>/dev/null)
    rbw unlock

    $nvim_bin -V10nvim_verbose_log-"$(date +"%Y-%m-%d-%H-%M-%S")".log $argv
end
