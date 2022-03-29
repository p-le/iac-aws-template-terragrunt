#!/bin/bash

FILE=.env
if [ -f "$FILE" ]; then
    echo "Set GitHub Action Secrets"
    export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
    gh secret set AWS_ACCESS_KEY_ID --body "$AWS_ACCESS_KEY_ID"
    gh secret set AWS_SECRET_ACCESS_KEY --body "$AWS_SECRET_ACCESS_KEY"
    gh secret set AWS_DEFAULT_REGION --body "$AWS_DEFAULT_REGION"
else
    echo "Please create .env file!"
fi
