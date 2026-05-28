# Bootstrap AWS Environment
Before deploying sites to a new AWS environment, the environment should be bootstrapped (creating the necessary resources) by following the instructions below.

## 🗺️ Navigate to boostrap directory
```bash
cd terraform/bootstrap/
```

## 🧹 Clean-up bootstrap directory
If they already exist, delete:
 - `.terraform/` 📁
 - `.terraform.lock.hcl` 📄
 - `.terraform.tfstate` ⚙️
 - `.terraform.tfstate.backup` 📄

## 🏗️ Initialise Terraform
If a `.terraform` directory already exists, delete it. Then run:
```bash
terraform init
```

## 🚀 Apply Terraform to AWS environment
Execute the `terraform apply` command with the target environment's shortcode (`dev`, `prod`, etc.) passed to the environment variable. For example, for dev you would run:
```bash
terraform apply -var="environment=dev"
```