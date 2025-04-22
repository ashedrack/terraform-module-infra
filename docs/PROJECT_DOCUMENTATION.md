# terraform-module-infra Documentation

## Introduction
`terraform-module-infra` is a best-practice Terraform project template designed for scalable, maintainable, and reusable cloud infrastructure. It leverages Terraform modules to enable rapid, consistent deployments across multiple environments (dev, staging, prod) and use cases.

---

## What are Terraform Modules?
Terraform modules are containers for multiple resources that are used together. A module encapsulates resource configurations and exposes input variables and outputs, making it easy to reuse and share infrastructure code.

### Key Concepts
- **Root Module:** The configuration in each environment (e.g., `environments/dev`) that calls reusable modules.
- **Child Module:** A reusable set of Terraform resources (e.g., `modules/compute`) called by the root module.
- **Input Variables:** Parameters to customize module behavior.
- **Outputs:** Values exported from a module for use elsewhere (e.g., subnet IDs).

---

## Project Use Cases
- **Multi-Environment Deployments:** Easily spin up isolated dev, staging, and prod environments with consistent infrastructure.
- **Rapid Prototyping:** Clone and adapt modules for new projects or cloud accounts.
- **Team Collaboration:** Standardize infrastructure patterns and enforce best practices across teams.
- **Scalable Cloud Architecture:** Expand infrastructure by adding new modules or extending existing ones.

---

## Benefits of Using This Project
### 1. **Reusability**
Write your infrastructure code once—in a module—and reuse it everywhere. No more copy-pasting resource blocks for each environment.

### 2. **Consistency**
All environments are guaranteed to have the same architecture, reducing drift and manual errors.

### 3. **Maintainability**
Update a module and instantly propagate improvements or fixes to every environment using it.

### 4. **Flexibility**
Easily customize each environment with variable files, without changing the module code.

### 5. **Scalability**
Add new resources or environments by creating or extending modules, keeping the codebase organized.

---

## How to Use Modules in This Project

### Example: Using the Compute Module
```hcl
module "compute" {
  source        = "../../modules/compute"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.network.subnet_id
  tags          = var.tags
}
```

### Example: Using the Network Module
```hcl
module "network" {
  source            = "../../modules/network"
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  tags              = var.tags
}
```

---

## Best Practices
- **Keep modules generic:** Accept variables for all settings that may change between uses.
- **Use outputs:** Export IDs or attributes needed by other modules or root configurations.
- **Document modules:** Add descriptions to variables and outputs.
- **Version control:** Use Git to track changes and enable collaboration.

---

## Further Reading
- [Terraform Modules Documentation](https://developer.hashicorp.com/terraform/language/modules)
- [Terraform Best Practices](https://developer.hashicorp.com/terraform/tutorials/modules/module-create)

---

## Conclusion
By adopting `terraform-module-infra`, you gain a robust foundation for any cloud project, with the power of Terraform modules to maximize reusability, maintainability, and scalability.
