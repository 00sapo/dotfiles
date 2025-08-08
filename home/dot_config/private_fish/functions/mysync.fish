function unlock_sudo_and_ssh
    # use pinentry to get a password and store it in a variable
    set -l pass (systemd-ask-password "Sudo/SSH password:")
    # unlock sudo
    echo $pass | sudo -S true
    # unlock ssh-agent using the $pass
    # there's a bug in ssh-add? if we give cat to SSH_ASKPASS, it reads from stderr...
    # need this workaround
    touch /tmp/pass
    chmod 700 /tmp/pass
    echo cat >/tmp/pass
    echo $pass | SSH_ASKPASS_REQUIRE=force SSH_ASKPASS=/tmp/pass ssh-add

    # erase the password
    rm /tmp/pass
    set -e pass
end

function chezmoi_update
    chezmoi re-add
    and chezmoi git fetch origin
    and chezmoi git rebase origin/main
    and chezmoi git push
    and chezmoi apply
end

function mysync
    unlock_sudo_and_ssh
    command -v soar >/dev/null; and soar info | head -n -1 | awk '{print $1}' >"$HOME/soar.install"
    command -v stew >/dev/null; and stew list --tags >"$HOME/stew.install"
    command -v chezmoi >/dev/null; and chezmoi_update
    command -v task >/dev/null; and task show taskd.server | grep -q wingtask; and task sync
end
