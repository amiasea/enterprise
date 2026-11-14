terraform {
  required_version = ">= 1.16.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.7.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.10"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

provider "azurerm" {
  alias = "institutive"
  subscription_id = "da348b35-29b6-4906-85ec-4a097aa5fe04"

  features {}
}

provider "azuread" {}