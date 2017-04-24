#!/usr/bin/env sh

# run ssh-agent
eval $(ssh-agent -s)

# create askpass script
SSH_ASKPASS_SCRIPT=/tmp/ssh-askpass-script
cat > "$SSH_ASKPASS_SCRIPT" <<EOL
#!/bin/bash
echo cat
EOL
chmod +x "$SSH_ASKPASS_SCRIPT"

# add ssh key stored in SSH_PRIVATE_KEY variable to the agent store
SSH_PRIVATE_FILE=/tmp/ssh_private_key
echo "$SSH_PRIVATE_KEY" > "$SSH_PRIVATE_FILE"
chmod 600 "$SSH_PRIVATE_FILE"
echo "$SSH_PASSPHRASE"| SSH_ASKPASS="$SSH_ASKPASS_SCRIPT" ssh-add "$SSH_PRIVATE_FILE"
rm "$SSH_PRIVATE_FILE" "$SSH_ASKPASS_SCRIPT"

# disable host key checking (NOTE: makes you susceptible to man-in-the-middle attacks)
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

exec "$@"
