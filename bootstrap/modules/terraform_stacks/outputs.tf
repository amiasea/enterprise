output "stack_subject_identifiers" {
  description = "Subject identifiers for registered HCP Terraform Stacks."

  value = module.pomology_propagation.stack_subject_identifiers
}

output "pomology_propagation_stack_id" {
  description = "Stack ID for registered HCP Terraform Stack."

  value = module.pomology_propagation.stack_id
}

output "pomology_propagation_stack_name" {
  description = "Stack Name for registered HCP Terraform Stack."

  value = module.pomology_propagation.stack_name
}

output "pomology_pruning_stack_id" {
  description = "Stack ID for registered HCP Terraform Stack."

  value = module.pomology_pruning.stack_id
}