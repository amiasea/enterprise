variable "azure_institutive_resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "institutive_federated_credential_subject_identifiers" {
  description = "Immutable GitHub OIDC subject identifiers trusted by the Institutive workload identity."
  type        = set(string)
}

variable "topology_federated_credential_subject_identifiers" {
  description = "GitHub OIDC subject identifiers trusted by the Orchard workload identity for topology repositories."
  type        = set(string)
  default     = []
}

variable "fruit_federated_credential_subject_identifiers" {
  description = "GitHub OIDC subject identifiers trusted by the Orchard workload identity for fruit repositories."
  type        = set(string)
  default     = []
}

variable "institutive_key_vault_id" {
  description = "The ID of the Institutive Key Vault."
  type        = string
}