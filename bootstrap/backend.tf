terraform {
  cloud {
    organization = "amiasea"

    workspaces {
      project = "imperative"
      name    = "enterprise"
    }
  }
}