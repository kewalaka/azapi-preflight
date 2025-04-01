terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }
}

provider "azapi" {
  enable_preflight = true
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
}

data "azapi_client_config" "current" {}

resource "azapi_resource" "storage_account" {
  type      = "Microsoft.Storage/storageAccounts@2024-01-01"
  name      = module.naming.storage_account.name_unique
  location  = "eastus2" # Intentionally incorrect location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"

  body = {
    sku = {
      name = "Standard_LRS"
    }
    kind       = "StorageV2"
    properties = {}
  }
}

variable "resource_group_name" {
  type    = string
  default = "rg-restrict-to-nz"
}
