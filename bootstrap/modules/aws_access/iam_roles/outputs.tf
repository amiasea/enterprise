output "orchard_publisher_name" {
  description = "Name of the Orchard publisher IAM role."
  value       = aws_iam_role.orchard_publisher.name
}

output "orchard_publisher_arn" {
  description = "ARN of the Orchard publisher IAM role."
  value       = aws_iam_role.orchard_publisher.arn
}