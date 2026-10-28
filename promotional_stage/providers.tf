terraform {
  required_version = ">= 1.16.2"

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
  alias = "imperative"
  subscription_id = "c7450111-a44d-47e1-86a4-dce7ad5769bf"

  features {}
}

provider "azuread" {}