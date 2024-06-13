function mysync
    command -v task >/dev/null; and task sync
    command -v chezmoi >/dev/null; and chezmoi update; and chezmoi re-add
end
