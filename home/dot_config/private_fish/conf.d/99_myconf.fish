# basic
set --export PATH "$HOME/.local/bin:$HOME/.local/share/soar/bin/:$PATH"

# asdf
source $HOME/.asdf/asdf.fish

# editor
if command -v nvim >/dev/null
    set --export EDITOR (which nvim)
    set --export SYSTEM_EDITOR (which nvim)
end

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
command -v pyenv >/dev/null; and status is-interactive; and pyenv init --path | source

# golang
if not set -q GOBIN
    set --export GOBIN "$HOME/go/bin"
end
# set --export GOROOT /usr/lib/go/
set --export PATH "$GOBIN:$PATH"
set --export GOCACHE "$HOME/go/cache"
# set --export GOPATH "$HOME/go"
# set --export GOMODCACHE "$HOME/go/pkg/mod"

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
