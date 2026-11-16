data "github_repositories" "orchard" {
  query           = "org:amiasea-enterprise-orchard archived:false"
  include_repo_id = true
}

locals {
  repositories = {
    for index, full_name in data.github_repositories.orchard.full_names :
    full_name => {
      name          = data.github_repositories.orchard.names[index]
      repository_id = data.github_repositories.orchard.repo_ids[index]
    }
  }

  repository_ids = toset([
    for repository in values(local.repositories) :
    repository.repository_id
  ])
}