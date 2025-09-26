function aichat --wraps='SHELL=fish /home/federico/.local/share/soar/bin/aichat' --description 'alias aichat SHELL=fish /home/federico/.local/share/soar/bin/aichat'
    set cmd (which aichat)
    set -x SHELL fish
    $cmd $argv
    history merge
end
