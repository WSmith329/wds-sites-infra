# WDS Sites Infrastructure

Create Terraform stacks and deploy them to AWS.

## Creating a Terraform stack for a new site
Each site should be created under the `clients` directory, with a new Terraform stack for each site.

### Prerequisites
The guide below assumes the following have already been completed:
 - A domain name has been purchased for the client site

### ♻️ Step 1 — Create a copy of the `example-client` directory
```bash
cd clients
cp -r example-client <CLIENT_APP_NAME>
```

### 🧹 Step 2 — Clean up new directory
If they exist, delete these from the new directory:
 - `.terraform`
 - `.terraform.lock.hcl`
 - `.terraform.tfstate`
 - `terraform.tfstate.backup`
```bash
cd <CLIENT_APP_NAME>
rm -rf .terraform .terraform.lock.hcl .terraform.tfstate terraform.tfstate.backup
```

### ⚙️ Step 3 — Update the backend config
Update the files in `backend_config` for each environment. Here is an example as of 01/06/2026:
```conf
bucket = "dev-sites-terraform-state"
key = "example-client/dev.tfstate"
region = "eu-west-2"
encrypt = true
use_lockfile = true
```

### 🟣 Step 4 — Update the tfvars
Update the files in `tfvars` for each environment. Here is an example as of 01/06/2026:
```tfvars
environment = "dev"

root_domain = "wds-example-client.com"
```

### 🌐 Step 5 - Manually create Route53 Hosted zone via AWS Console
On the AWS Console, navigate to Route53 -> Hosted zones -> Created hosted zone. Fill in the form and press **Created hosted zone**:
 1. Domain name - The client's domain
 2. Description - Not required
 3. Type - Public hosted zone
 4. Tags - Not required


### 🚀 Step 6 - Deploy stack to AWS
On GitHub, navigate to Actions -> Deploy a Client Site -> Run workflow. Fill in the form and press **Run workflow**:
 1. Branch - The Git branch with the changes to be deployed
 2. Environment - The AWS environment to deploy the changes to
 3. Client folder - The client stack to be deployed


## License

[MIT](https://choosealicense.com/licenses/mit/)