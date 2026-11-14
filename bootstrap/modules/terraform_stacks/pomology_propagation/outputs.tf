output "stack_subject_identifiers" {
  description = "Subject identifiers for registered HCP Terraform Stacks."

  value = [
    {
      name = tfe_stack.enterprise_pomology_propagation.name
      subject_identifier = "organization:${var.tfe_organization_name}:project:${var.tfe_project.name}:stack:${tfe_stack.enterprise_pomology_propagation.name}:deployment:pomology:operation:*"
    },
    {
      name = "${tfe_stack.enterprise_pomology_propagation.name}-test"
      subject_identifier = "organization:${var.tfe_organization_name}:project:${var.tfe_project.name}:stack:${tfe_stack.enterprise_pomology_propagation.name}:deployment:pomology_testing:operation:*"
    }
  ]
}

output "stack_id" {
  description = "Stack ID for registered HCP Terraform Stack."

  value = tfe_stack.enterprise_pomology_propagation.id
}

output "stack_name" {
  description = "Stack Name for registered HCP Terraform Stack."

  value = tfe_stack.enterprise_pomology_propagation.name
}