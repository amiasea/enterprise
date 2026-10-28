output "stack_subject_identifiers" {
  description = "Subject identifiers for registered HCP Terraform Stacks."

  value = [
    {
      name = tfe_stack.enterprise_solution_actualization.name
      subject_identifier = "organization:${var.tfe_organization_name}:project:${var.tfe_project.name}:stack:${tfe_stack.enterprise_solution_actualization.name}:deployment:solutions:operation:*"
    }
  ]
}