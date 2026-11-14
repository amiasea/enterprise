terraform {
  required_version = ">= 1.16.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.7.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.82.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.13.0"
      configuration_aliases = [ github.enterprise_orchard ]
    }
  }
}