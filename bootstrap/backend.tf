terraform {
  cloud {
    organization = "amiasea"

    workspaces {
      project = "institutive"
      name    = "enterprise"
    }
  }
}