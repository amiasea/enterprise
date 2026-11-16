resource "aws_iam_role_policy" "orchard_publisher" {
  name = "orchard-publisher"
  role = var.role_name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid      = "PublishPackages"
        Effect   = "Allow"
        Action   = "codeartifact:PublishPackageVersion"
        Resource = "${var.orchard_packages_repository_arn}:*"
      },
      {
        Sid      = "GetAuthorizationToken"
        Effect   = "Allow"
        Action   = "codeartifact:GetAuthorizationToken"
        Resource = var.codeartifact_domain_arn
      },
      {
        Sid      = "GetServiceBearerToken"
        Effect   = "Allow"
        Action   = "sts:GetServiceBearerToken"
        Resource = "*"

        Condition = {
          StringEquals = {
            "sts:AWSServiceName" = "codeartifact.amazonaws.com"
          }
        }
      }
    ]
  })
}