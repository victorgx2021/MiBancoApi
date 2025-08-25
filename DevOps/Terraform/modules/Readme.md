# 1. Prepare
## 1.1 Install terraform
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
Install the HashiCorp GPG key.
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
Verify the key's fingerprint.
```bash
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
Add the official HashiCorp repository to your system. 
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
Install Terraform from the new repository.
```bash
sudo apt update
```
```bash
sudo apt-get install terraform -y
```
Enable tab completion
```bash
touch ~/.bashrc
```
```bash
terraform -install-autocomplete
```
>To more information, [*click here*](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli).

# 2. Basic commands
### 2.1 Init
Initialize the project, which downloads a plugin called a provider that lets Terraform interact with Docker.
```bash
terraform init
```

### 2.2 Format
Format your configuration. Terraform will print out the names of the files it modified, if any.
```bash
terraform fmt
```

### 2.3 Validate
You can also make sure your configuration is syntactically valid and internally consistent.
```bash
terraform validate
```

### 2.4 Plan
To see any changes that are required for your infrastructure.
```bash
terraform plan
```

### 2.5 Apply
```bash
terraform apply
```

### 2.6 Show
Inspect the current state.
```bash
terraform show
```
```bash
terraform state list
```

### 2.7 Destroy
```bash
terraform destroy
```

# 3. Terraform with azure
### 3.1 Prerequisites
The [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/) installed.

### 3.2 Authenticate using the Azure CLI
```bash
az login
```

Find the `id` column for the subscription account you want to use.
Once you have chosen the account subscription ID, set the account with the Azure CLI.
```bash
az account set --subscription "[subscription ID]"
```
### 3.3 Create a Service Principal
Next, create a Service Principal. A Service Principal is an application within Azure Active Directory with the
authentication tokens Terraform needs to perform actions on your behalf.
```bash
az ad sp create-for-rbac2 --name="some-name" --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```

### 3.4  List subscriptions
```bash
az account list
```
