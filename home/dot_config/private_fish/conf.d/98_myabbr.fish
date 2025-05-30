abbr -a -- pdm-shell 'eval (pdm venv activate in-project)'
abbr -a -- fix-camera-freq 'v4l2-ctl --set-ctrl=power_line_frequency='
abbr -a -- conda-shell eval\ $HOME/.pyenv/versions/mambaforge/bin/conda\ \'shell.fish\'\ \'hook\'\ \ \|\ source
abbr -a -- conda-activate 'conda activate (realpath .venv)'
abbr -a -- pacman-autoremove 'sudo pacman -Rs (pacman -Qtdq)'
abbr -a -- plasmashell-fix 'kquitapp5 plasmashell && kstart5 plasmashell &'
abbr -a -- brianproxy 'ssh -D 8989 -C -q -N -o ControlMaster=no brian.lim.di.unimi.it'
abbr -a -- distrobox-update 'curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local'
abbr -a -- dhe distrobox-host-exec
abbr -a -- reverse-ssh 'ssh -C -q -N -o ControlMaster=no -R 4833:localhost:4833'
abbr -a -- defrankestein 'aptitude search -F "%p %O %v %d Dependants:%r" "?narrow(?and(?not(?automatic),?installed),?or(?not(?archive(stable)),?not(?origin(debian))))"'
abbr -a -- t task
abbr -a -- ts 'task sync'
abbr -a -- ta 'task add'
abbr -a -- td 'task done'
abbr -a -- tm 'task modify'
abbr -a -- ghs 'gh copilot suggest'
abbr -a -- ghe 'gh copilot explain'
abbr -a -- a 'aichat -e '
