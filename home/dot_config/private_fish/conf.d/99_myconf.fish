# avoid double sourcing of this file
if not set -q myconf_loaded
    set -g myconf_loaded 1
else
    return
end

# asdf
source $HOME/.asdf/asdf.fish

# nix
# already set in .profile
# set --export PATH "$HOME/.nix-profile/bin:$PATH"
set --export NIXPKGS_ALLOW_UNFREE 1

# set local bin path after nix (so we can override it)
# already set in .profile
# set --export PATH "$HOME/.local/bin:$PATH"

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
