#!/usr/bin/env sh

# run ssh-agent
eval $(ssh-agent -s)

# add ssh key stored in SSH_PRIVATE_KEY variable to the agent store
echo "$SSH_PRIVATE_KEY" > ssh_private_key
ssh-add < ssh_private_key
rm ssh_private_key

# disable host key checking (NOTE: makes you susceptible to man-in-the-middle attacks)
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

exec "$@"
