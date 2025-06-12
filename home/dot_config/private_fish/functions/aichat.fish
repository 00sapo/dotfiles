function aichat --wraps='SHELL=fish /home/federico/.local/bin/aichat' --description 'alias aichat SHELL=fish /home/federico/.local/bin/aichat'
    SHELL=fish /home/federico/.local/bin/aichat $argv
    history merge
end
