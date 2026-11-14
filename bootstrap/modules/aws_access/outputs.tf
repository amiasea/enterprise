output "pomology_propagation_role_arn" {
  description = "ARN of the IAM role assumed by the enterprise pomology propagation Stack."
  value       = aws_iam_role.pomology_propagation_role.arn
}

output "pomology_artifact_role_boundary_arn" {
  description = "ARN of the IAM policy used as a permissions boundary for pomology-specific artifact publish and restore roles."
  value = aws_iam_policy.pomology_artifact_role_boundary.arn
}