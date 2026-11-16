locals {
  repositories = {
    for index, full_name in data.github_repositories.institutive_repositories.full_names :
    full_name => {
      name          = data.github_repositories.institutive_repositories.names[index]
      repository_id = data.github_repositories.institutive_repositories.repo_ids[index]
    }
  }

  institutive_repositories = {
    for full_name, repository in local.repositories :
    full_name => repository
    if contains(
      data.github_repository_custom_properties.institutive[repository.name].property,
      {
        property_name  = "institutive"
        property_value = toset(["true"])
      }
    )
  }

  enterprise_repositories = {
    for full_name, repository in local.repositories :
    full_name => repository
    if startswith(repository.name, "enterprise-")
  }

  institutive_repository_ids = toset([
    for repository in values(local.institutive_repositories) :
    repository.repository_id
  ])
}