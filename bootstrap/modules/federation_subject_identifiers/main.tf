locals {
  institutive_federated_credential_subject_identifiers = toset([
    for repository in values(var.institutive_repositories) :
    "repo:${var.github_organization_name}@${var.github_organization_id}/${repository.name}@${repository.repository_id}:ref:refs/heads/main"
  ])

  topology_federated_credential_subject_identifiers = toset([
    for repository in values(var.topology_repositories) :
    "repo:${var.github_enterprise_orchard_organization_name}@${var.github_enterprise_orchard_organization_id}/${repository.name}@${repository.repository_id}:pull_request"
  ])

  orchard_federated_credential_subject_identifiers = toset([
    for repository in values(var.orchard_repositories) :
    "repo:${var.github_enterprise_orchard_organization_name}@${var.github_enterprise_orchard_organization_id}/${repository.name}@${repository.repository_id}:pull_request"
  ])
}