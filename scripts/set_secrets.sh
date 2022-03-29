#!/bin/bash
# Set GitHub Actions Secrets to be able to run GitHub Actions Workflow
# Required Files:
# -  .env
# -  infrastructure-live/common_vars.yaml
# Please check .example files and create

if [ -f ".env" ]; then
    echo "Set GitHub Action Secrets from .env"
    export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
    gh secret set AWS_ACCESS_KEY_ID --body "$AWS_ACCESS_KEY_ID"
    gh secret set AWS_SECRET_ACCESS_KEY --body "$AWS_SECRET_ACCESS_KEY"
    gh secret set AWS_DEFAULT_REGION --body "$AWS_DEFAULT_REGION"
else
    echo "Please create .env file!"
fi

if [ -f "infrastructure-live/common_vars.yaml" ]; then
    echo "Set GitHub Action Secrets from common_vars.yaml"
    base64 infrastructure-live/common_vars.yaml > infrastructure-live/common_vars.yaml.base64
    gh secret set COMMON_VARS_YAML < infrastructure-live/common_vars.yaml.base64
    rm -rf infrastructure-live/common_vars.yaml.base64
else
    echo "Please create common_vars.yaml file!"
fi
