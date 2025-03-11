function mysync
    command -v chezmoi >/dev/null; and chezmoi update --apply=false
    command -v chezmoi >/dev/null; and chezmoi re-add
    command -v chezmoi >/dev/null; and chezmoi apply
    command -v task >/dev/null; and task show taskd.server | grep -q wingtask; and task sync
end
