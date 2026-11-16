module "orchard_publisher_trust" {
  source = "./iam_trust_policies"

  github_actions_oidc_provider_arn = var.github_actions_oidc_provider_arn
  github_subject_identifiers       = var.github_subject_identifiers
}

module "orchard_publisher_role" {
  source = "./iam_roles"

  assume_role_policy = module.orchard_publisher_trust.orchard_publisher_json
}

module "orchard_publisher_permissions" {
  source = "./iam_permissions_policies"

  role_name                       = module.orchard_publisher_role.orchard_publisher_name
  orchard_packages_repository_arn = var.orchard_packages_repository_arn
  codeartifact_domain_arn         = var.codeartifact_domain_arn
}