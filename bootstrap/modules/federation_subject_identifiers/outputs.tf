output "institutive_federated_credential_subject_identifiers" {
  value = local.institutive_federated_credential_subject_identifiers
}

output "topology_federated_credential_subject_identifiers" {
  description = "Federated credential subject identifiers for Orchard topology repositories."
  value       = local.topology_federated_credential_subject_identifiers
}

output "orchard_federated_credential_subject_identifiers" {
  description = "Federated credential subject identifiers for Orchard fruit repositories."
  value       = local.orchard_federated_credential_subject_identifiers
}