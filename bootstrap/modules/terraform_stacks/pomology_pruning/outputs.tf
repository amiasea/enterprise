output "stack_id" {
  description = "Stack ID for registered HCP Terraform Stack."

  value = tfe_stack.enterprise_pomology_pruning.id
}