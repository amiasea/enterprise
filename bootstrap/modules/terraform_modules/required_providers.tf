terraform {
  required_version = ">= 1.16.5"

  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.82.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.13.0"
    }
  }
}