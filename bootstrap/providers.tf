terraform {
  required_version = ">= 1.16.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.7.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "2.13.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.82.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.68.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.13.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.28.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "imperative"
  subscription_id = "c7450111-a44d-47e1-86a4-dce7ad5769bf"
  features {}
}

provider "azapi" {}

provider "tfe" {
  organization = var.tfe_organization_name
}

provider "tfe" {
  alias        = "development"
  organization = var.tfe_organization_name
  token        = var.tfe_development_token
}

provider "aws" {
  region  = "us-east-1"
  profile = "amiasea"
}

provider "github" {
  owner = "amiasea"

  app_auth {
  }
}

provider "cloudflare" {}

provider "aws" {
  alias      = "r2"
  region     = "auto"
  access_key = var.r2_access_key_id
  secret_key = var.r2_secret_access_key

  endpoints {
    s3 = "https://${var.cloudflare_account_id}.r2.cloudflarestorage.com"
  }

  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true
}
