terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-restrict-to-nz"
  location = "New Zealand North"
}

resource "azurerm_resource_group_policy_assignment" "restrict_locations_assignment" {
  name              = "restrict-locations-assignment"
  resource_group_id = azurerm_resource_group.rg.id
  # https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailAdaptor.ReactView/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fe56962a6-4747-49cd-b67b-bf8b01975c4c
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  parameters           = <<PARAMS
{
  "listOfAllowedLocations": {
    "value": ["newzealandnorth"]
  }
}
PARAMS
}

