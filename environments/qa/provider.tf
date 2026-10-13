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
  tenant_id = "f23b5b26-4402-4886-aa05-827061c0d1d1"
}

provider "azurerm" {
  features {}
  subscription_id = "ed0d050d-86c4-4b4a-8227-7630fc9179eb"
  tenant_id       = local.tenant_id
}
