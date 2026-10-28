
data "github_organization" "amiasea" {
  name = "amiasea"
}

data "aws_region" "current" {}

locals {
  codeartifact_package_repositories = merge(
    module.aspect_option_artifacts.package_repository_names,
    {
      enterprise = aws_codeartifact_repository.enterprise_package_repository.repository
    }
  )

  codeartifact_nuget_urls = {
    for codename, repository in local.codeartifact_package_repositories :
    codename => "https://${module.artifact_foundation.codeartifact_domain}-${module.artifact_foundation.codeartifact_domain_owner}.d.codeartifact.${data.aws_region.current.name}.amazonaws.com/nuget/${repository}/v3/index.json"
  }

  codeartifact_npm_urls = {
    for codename, repository in local.codeartifact_package_repositories :
    codename => "https://${module.artifact_foundation.codeartifact_domain}-${module.artifact_foundation.codeartifact_domain_owner}.d.codeartifact.${data.aws_region.current.name}.amazonaws.com/npm/${repository}/"
  }
}

resource "github_actions_organization_variable" "aws_account_id" {
  variable_name = "AWS_ACCOUNT_ID"
  value         = module.artifact_foundation.aws_account_id
  visibility    = "all"
}

resource "github_actions_organization_variable" "codeartifact_domain" {
  variable_name = "CODEARTIFACT_DOMAIN"
  value         = module.artifact_foundation.codeartifact_domain
  visibility    = "all"
}

resource "github_actions_organization_variable" "codeartifact_nuget_url" {
  for_each = local.codeartifact_nuget_urls

  variable_name = "CODEARTIFACT_${upper(replace(each.key, "-", "_"))}_NUGET_URL"
  value         = each.value
  visibility    = "all"
}

resource "github_actions_organization_variable" "codeartifact_npm_url" {
  for_each = local.codeartifact_npm_urls

  variable_name = "CODEARTIFACT_${upper(replace(each.key, "-", "_"))}_NPM_URL"
  value         = each.value
  visibility    = "all"
}

resource "github_actions_organization_variable" "ecr_repository" {
  for_each = module.aspect_option_artifacts.ecr_repository_urls

  variable_name = "ECR_${upper(replace(each.key, "-", "_"))}_REPOSITORY_URL"
  value         = each.value
  visibility    = "all"
}

resource "github_actions_organization_variable" "artifact_publish_role_arn" {
  variable_name = "ARTIFACT_PUBLISH_ROLE_ARN"
  value         = module.artifact_access.enterprise_publish_role_arn
  visibility    = "all"
}

resource "github_actions_organization_variable" "artifact_restore_role_arn" {
  variable_name = "ARTIFACT_RESTORE_ROLE_ARN"
  value         = module.artifact_access.enterprise_restore_role_arn
  visibility    = "all"
}