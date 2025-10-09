# basic
set --export PATH "$HOME/.local/bin:$PATH"

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end
# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# editor
if command -v nvim >/dev/null
    set --export EDITOR (which nvim)
    set --export SYSTEM_EDITOR (which nvim)
end

# javascript
set --export PATH "$HOME/.npm-global/bin:$PATH"

# java
set --export JAVA_HOME ""

# # golang
# if not set -q GOBIN
#     set --export GOBIN "$HOME/go/bin"
# end
# # set --export GOROOT /usr/lib/go/
# set --export PATH "$GOBIN:$PATH"
# set --export GOCACHE "$HOME/go/cache"
# # set --export GOPATH "$HOME/go"
# # set --export GOMODCACHE "$HOME/go/pkg/mod"
#
# # rust
# set --export PATH "$HOME/.cargo/bin:$PATH"

# mlflow
# set --export MLFLOW_TRACKING_URI "$HOME/mlruns"

# ladspa
set --export LADSPA_PATH "$LADSPA_PATH:/usr/lib/ladspa"

# # Apptainer
# set --export PATH "$HOME/.local/opt/apptainer-relocatable/bin/:$PATH"

# nvim
# set --export NVIM_LISTEN_ADDRESS "/tmp/nvimsocket"
