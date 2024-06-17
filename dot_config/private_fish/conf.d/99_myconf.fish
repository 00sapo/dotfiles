# basic
set --export PATH "$HOME/.local/bin/:$PATH"

# snap
set --export PATH "/snap/bin:$PATH"

# editor
set --export EDITOR (which nvim)
set --export SYSTEM_EDITOR (which nvim)

# nim
set --export PATH "$HOME/.nimble/bin:$PATH"

# ruby
set --export PATH "$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

# javascript
set --export PATH "$HOME/.npm-global/bin:$PATH"

# java
set --export JAVA_HOME ""

# pyenv
set -x PATH "$HOME/.pyenv/bin:$PATH"
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
command -v pyenv >/dev/null; and status is-login; and pyenv init --path | source

# golang
if set -q $GOBIN
    set --export PATH "$GOBIN/bin:$PATH"
else
    set --export PATH "$HOME/go/bin:$PATH"
end
set --export GOCACHE "$HOME/go/cache"

# rust
set --export PATH "$HOME/.cargo/bin:$PATH"

# mlflow
# set --export MLFLOW_TRACKING_URI "$HOME/mlruns"

# ladspa
set --export LADSPA_PATH "$LADSPA_PATH:/usr/lib/ladspa"

# Apptainer
set --export PATH "$HOME/.local/opt/apptainer-relocatable/bin/:$PATH"

# nvim
# set --export NVIM_LISTEN_ADDRESS "/tmp/nvimsocket"
