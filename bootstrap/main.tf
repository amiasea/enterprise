module "aws_artifact_foundation" {
  source = "./modules/artifact_foundation"
}

module "tfe_stacks" {
  source = "./modules/tfe_stacks"

  tfe_token = var.tfe_token

  tfe_github_app_installation_id = data.tfe_github_app_installation.gha_installation.id

  tfe_organization_name = var.tfe_organization_name

  tfe_project = data.tfe_project.institutive
}

module "aws_access" {
  source = "./modules/aws_access"

  hcp_terraform_oidc_provider_arn = module.aws_artifact_foundation.github_oidc_provider_arn
  solution_actualization_stack_subject_identifiers = [
    for stack in module.tfe_stacks.stack_subject_identifiers : stack.subject_identifier
    if contains([
      "enterprise-solution-actualization",
    ], stack.name)
  ]
}