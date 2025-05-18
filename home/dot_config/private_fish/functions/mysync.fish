function unlock_sudo_ssh_rbw
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

    # unlock rbw
    command -v rbw; and rbw unlock
end

function chezmoi_update
    chezmoi re-add
    and chezmoi git fetch origin
    and chezmoi git rebase origin/main
    and chezmoi git push
    and chezmoi apply
end

function mongodb_update
    set -l pass (rbw get "cloud.mongodb.com librechat-cluster")
    # create a backup of the database
    set -l uri "mongodb+srv://sapo:$pass@librechat-cluster.d8wv42m.mongodb.net/LibreChat?retryWrites=true"
    mongodump --uri $uri --out $HOME/MEGA/backups/mongo
end

function mysync
    unlock_sudo_ssh_rbw
    command -v chezmoi >/dev/null; and chezmoi_update
    command -v task >/dev/null; and task show taskd.server | grep -q wingtask; and task sync
    command -v rbw >/dev/null; and rbw sync
    command -v mongodump >/dev/null; and command -v rbw >/dev/null; and mongodb_update
end
