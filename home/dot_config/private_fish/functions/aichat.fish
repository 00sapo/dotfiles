function aichat --wraps='SHELL=fish /home/federico/.local/share/soar/bin/aichat' --description 'alias aichat SHELL=fish /home/federico/.local/share/soar/bin/aichat'
    SHELL=fish /home/federico/.local/share/soar/bin/aichat $argv
    history merge
end
