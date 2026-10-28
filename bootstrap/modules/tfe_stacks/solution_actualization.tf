data "tfe_organization" "organization" {
  name = var.tfe_organization_name
}

resource "tfe_stack" "enterprise_solution_actualization" {
  name              = "enterprise-solution-actualization"
  description       = "Actualizes Amiasea enterprise solution definitions."
  project_id        = var.tfe_project.id
  working_directory = "src"

  vcs_repo {
    identifier                 = "amiasea/enterprise-solution-actualization"
    github_app_installation_id = var.tfe_github_app_installation_id
  }
}

resource "terraform_data" "stack_tag_trigger" {
  triggers_replace = [
    tfe_stack.enterprise_solution_actualization.id,
    var.stack_tags_regex,
  ]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    environment = {
      TFE_TOKEN = var.tfe_token
    }

    command = <<-EOT
      curl --fail-with-body --silent --show-error \
        --request PATCH \
        --url "https://app.terraform.io/api/v2/stacks/${tfe_stack.enterprise_solution_actualization.id}" \
        --header "Authorization: Bearer $TFE_TOKEN" \
        --header "Content-Type: application/vnd.api+json" \
        --data '${jsonencode({
                  data = {
                    type = "stacks"
                    id   = tfe_stack.enterprise_solution_actualization.id
                    attributes = {
                      "vcs-repo" = {
                        branch       = ""
                        "tags-regex" = var.stack_tags_regex
                      }
                    }
                  }
              })}'
            EOT
  }
}

resource "tfe_variable_set" "solution_actualization_varset" {
  name         = "enterprise-solution-actualization"
  description  = "Enterprise Solution Actualization Varset."
  organization = tfe_organization.organization.id
}

resource "tfe_stack_variable_set" "solution_actualization_stack_varset" {
  stack_id        = tfe_stack.enterprise_solution_actualization.id
  variable_set_id = tfe_variable_set.solution_actualization_varset.id
}
