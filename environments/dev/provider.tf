terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

locals {
  tenant_id = "REPLACE_WITH_YOUR_TENANT_ID"
}

provider "azurerm" {
  features {}
  subscription_id = "REPLACE_WITH_YOUR_SUBSCRIPTION_ID"
  tenant_id       = local.tenant_id
}
