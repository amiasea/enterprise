variable "azure_institutive_resource_group_name" {
  type = string
}

variable "azure_institutive_resource_group_id" {
  type = string
}

variable "location" {
  type = string
}

variable "institutive_federated_credential_subject_identifiers" {
  description = "Immutable GitHub OIDC subject identifiers trusted by the Institutive workload identity."
  type        = set(string)
}

variable "institutive_key_vault_id" {
  description = "The ID of the Institutive Key Vault."
  type        = string
}

variable "tfe_institutive_project_name" {
  type = string
}

variable "tfe_pomology_propagation_stack_name" {
  type = string
}