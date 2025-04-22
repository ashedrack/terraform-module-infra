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

## License
MIT
