#!/bin/bash
# Generate a SSH Key to current Workspace
# Can also use as EC2 Key Pair if needed
if [ ! -d ".ssh" ]; then
    mkdir -p .ssh
fi

echo "--Generate SSH Key if not exist. Press N to skip overwrite!"
ssh-keygen -q -t rsa -b 4096 -f .ssh/id_rsa -N ''

echo "--Check AWS Secret Manager"
SSH_SECRET_NAME="terragrunt-examples-ssh-key"
SSH_SECRET=$(aws secretsmanager get-secret-value --secret-id $SSH_SECRET_NAME)
if [[ $? -eq 0 ]]; then
    SECRET_ID=$(jq '.VersionId' <<< $SSH_SECRET)
    echo "--Secret ID: $SECRET_ID"
else
    echo "--SSH Secret does not exist. Create new Secret for SSH Key"
    aws secretsmanager create-secret \
        --name $SSH_SECRET_NAME \
        --description "SSH Key for Terragrunt examples" \
        --secret-string file://./.ssh/id_rsa.pub
fi
