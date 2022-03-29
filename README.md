# How to use this template

Using Terragrunt to provision infrastructure on AWS.

Using VS Code Remote Containers.

## Step 1: Setup VS Code

- Install VS Code Remote Container Extensions

## Step 2: Prepare AWS credentials

- Create new IAM User
- Grant some IAM Roles. For examples: `IAMFullAccess`, `EC2FullAccess`, `S3FullAccess`
- Generate new `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
- Create File: `.env` based on `.env.example`

## Step 3: Develop

1. Update Terraform Code in `modules`
2. Set commond variables: `environments/common_vars.yaml`. Copy/Paste from `environments/common_vars.yaml.example`
3. Execute Terragrunt commands

```
cd environments/demo
terragrunt run-all plan
terragrunt run-all apply
```

**MY NOTES:**

- `modules` folder: To make this template simple to setup, I've used local Terraform modules. You can create another GitHub Repositories as Terraform Modules and refer to them
- `infrastructure-live/demo` folder: This is template's temporary folder. Generally it should be environment name: `staging`, `production`, `canary`, `qa`, `production-canary` and so on.
- `infrastructure-live/common_vars.yaml`: this file's content will change depends on the person who use this repository. so I've ignore it in `.gitignore`. Same as `terraform.tfvars` and `.env`

# How to Use GitHub Actions Workflows

- Run `./scripts/setup.sh` to install GitHub CLI and authorize. We use GitHub CLI to manage GitHub Action Secrets
- Run `./scripts/set_secrets.sh` to register GitHub Actions Secrets by reading `.env`, `infrastructure-live/common_vars.yaml`

| Workflow     | Description                                                 |
| ------------ | ----------------------------------------------------------- |
| plan.yaml    | Run Terragrunt validate & plan to confirm Terraform Modules |
| apply.yaml   | Apply Infrastructure changes without approval               |
| destroy.yaml | Destroy Infrastructure without approval                     |
