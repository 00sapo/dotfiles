#!/bin/sh
# start an agent to cache passphrases
eval "$(ssh-agent)"
ssh-add ~/.ssh/id_rsa
# cache sudo credentials
eval "sudo -v"
topgrade
# stop the agent
eval "$(ssh-agent -k)"
