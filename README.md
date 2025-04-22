# terraform-module-infra

A modular, reusable Terraform infrastructure project supporting multiple environments (dev, staging, prod) with best practices for code reusability, scalability, and maintainability.

## Features
- **Environment Isolation:** Separate configurations for dev, staging, and prod.
- **Modular Design:** Centralized modules for compute (EC2), network (VPC, Subnet), and data (S3) resources.
- **Easy Deployment:** GitHub Actions workflow for selecting environment and Terraform action (init, plan, apply).
- **Parameterization:** All resources are configurable via variables for flexibility and DRY code.

## Project Structure
```
terraform/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
└── modules/
    ├── compute/
    ├── network/
    └── data/
```

## Quick Start
1. Clone the repo and navigate to the `environments/<env>` directory (e.g., `dev`).
2. Update the `*.tfvars` file with your environment-specific values.
3. Run:
   ```sh
   terraform init
   terraform plan -var-file=dev.tfvars
   terraform apply -var-file=dev.tfvars
   ```
4. Or use the GitHub Actions workflow for automated deployment.

## GitHub Actions Workflow
- Go to Actions > Terraform Deploy > Run workflow
- Select environment and action (init, plan, apply)

## Requirements
- Terraform >= 1.0
- AWS credentials (set as environment variables or GitHub secrets)

## Remote State Setup
To enable remote state and state locking, create an S3 bucket and DynamoDB table:

```sh
# Create S3 bucket (choose a globally unique name)
aws s3api create-bucket --bucket terraform-module-infra-state --region us-west-2

# Enable bucket encryption (recommended)
aws s3api put-bucket-encryption --bucket terraform-module-infra-state --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-west-2
```

After configuring your backend, re-initialize Terraform in each environment:

```sh
terraform -chdir=environments/dev init
terraform -chdir=environments/staging init
terraform -chdir=environments/prod init
```

## CI/CD Automation

This project uses a two-stage GitHub Actions pipeline for safe, automated infrastructure management:

### 1. Prerequisite Workflow (`terraform-prereq.yml`)
- Ensures the S3 bucket and DynamoDB table for remote state and locking exist.
- Runs automatically before any Terraform deployment.
- Uses AWS credentials from GitHub Secrets.

### 2. Main Deploy Workflow (`terraform-deploy.yml`)
- Waits for the prerequisite workflow to complete (using GitHub's `workflow_call` and `needs` dependency).
- Allows you to select the environment (`dev`, `staging`, or `prod`) and the Terraform action (`init`, `plan`, `apply`, `destroy`).
- Uses the correct remote backend for each environment.

#### Usage:
- Trigger the main workflow (`Terraform Deploy`) from the Actions tab.
- The pipeline will first run the prerequisites, then proceed to deploy or manage infrastructure as requested.

#### Required GitHub Secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`

For more details, see the workflow files in `.github/workflows/`.

## License
MIT
