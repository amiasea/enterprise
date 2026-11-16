output "repositories" {
  description = "Repositories designated with the type custom property and value of 'fruit."
  value       = local.repositories
}

output "repository_ids" {
  description = "GitHub repository IDs designated as fruit."
  value       = local.repository_ids
}