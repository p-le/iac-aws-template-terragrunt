#!/bin/bash
# Generate a SSH Key to current Workspace
# Can also use as EC2 Key Pair if needed
if [ ! -d ".ssh" ]; then
    mkdir -p .ssh
fi

ssh-keygen -t rsa -b 4096 -f .ssh/id_rsa
