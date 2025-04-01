# Testing preflight

This demo showcases one of the capabilities of AzAPI preflight, namely catching policy violations at plan.

The process involves deploying a resource group with the location restriction policy applied `setup\main.tf`,
followed by testing that restriction `demo\main.tf`.

## Prerequisites

Ensure you have the Azure CLI and Terraform installed on your system.

Or use the provided Codespace.

## Step 1: Set the ARM Tenant and Subscription ID

Run the following commands to set your Azure tenant and subscription ID

```text
# shell
export ARM_TENANT_ID="<your-tenant-id>"
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"

# or pwsh
$env:ARM_TEMAMT_ID="<your-tenant-id>"
$env:ARM_SUBSCRIPTION_ID="<your-tenant-id>"
```

Replace `<your-tenant-id>` and `<your-subscription-id>` with your actual Azure tenant and subscription IDs.

## Step 2: Run the Setup

Navigate to the `setup` folder and run the `main.tf` file:

```bash
cd setup
terraform init
terraform apply
```

This will deploy a resource group with a policy to validate resource locations.

## Step 3: Test the Demo

Run the following commands to test the deployment:

```bash
cd ../demo
terraform init
terraform validate # question, do you think this will work?
terraform plan
```

This will attempt to create a storage account in an invalid location, triggering the preflight validation.

## Step 4: Explore removing the pre-flight

Try disabling the preflight, i.e. set the following in `demo\main.tf`

```terraform
provider "azapi" {
  # or remove this line, as false is the default (at the time of writing)
  enable_preflight = false
}
```
