#!/bin/sh
# start an agent to cache passphrases
eval "$(ssh-agent)"
ssh-add ~/.ssh/id_rsa
eval "sudo -v"
topgrade
eval "$(ssh-agent -k)"
