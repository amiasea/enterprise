output "orchard_publisher_json" {
  description = "JSON trust policy document for the Orchard publisher role."
  value       = data.aws_iam_policy_document.orchard_publisher_trust.json
}