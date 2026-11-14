terraform {
  required_version = ">= 1.16.5"

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
  alias           = "institutive"
  subscription_id = "bf451fd9-d382-4da8-9c1a-179a96a4d2f3"
  features {}
}

provider "azapi" {}

provider "tfe" {
  organization = var.tfe_organization_name
  token        = var.tfe_token
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

# provider "github" {
#   alias = "enterprise_solution"
#   owner = "amiasea-enterprise-orchard"
#   app_auth {
#     id              = var.amiasea_github_app_id
#     installation_id = var.enterprise_orchard_github_app_installation_id
#     pem_file        = var.amiasea_github_app_pem_file
#   }
# }

provider "github" {
  alias = "enterprise_orchard"
  owner = "amiasea-enterprise-orchard"
  app_auth {
    id              = var.amiasea_github_app_id
    installation_id = var.enterprise_orchard_github_app_installation_id
    pem_file        = var.amiasea_github_app_pem_file
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
