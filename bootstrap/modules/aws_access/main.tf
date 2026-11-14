data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "pomology_propagation_role_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.hcp_terraform_oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }

    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = var.pomology_propagation_stack_subject_identifiers
    }
  }
}

data "aws_iam_policy_document" "pomology_propagation_role_permissions" {

  statement {
    sid    = "CreatePomologyArtifactRolesWithBoundary"
    effect = "Allow"

    actions = [
      "iam:CreateRole",
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/amiasea-*"
    ]

    condition {
      test     = "ArnEquals"
      variable = "iam:PermissionsBoundary"
      values   = [aws_iam_policy.pomology_artifact_role_boundary.arn]
    }
  }

  statement {
    sid    = "ManagePomologyArtifactRoles"
    effect = "Allow"

    actions = [
      "iam:GetRole",
      "iam:DeleteRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:PutRolePolicy",
      "iam:GetRolePolicy",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:DeleteRolePolicy",
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/amiasea-*"
    ]
  }

  statement {
    sid    = "ECRRepositoryManagement"
    effect = "Allow"

    actions = [
      "ecr:CreateRepository",
      "ecr:DescribeRepositories",
      "ecr:DeleteRepository",
      "ecr:ListTagsForResource",
      "ecr:TagResource",
      "ecr:UntagResource",
    ]

    resources = [
      "arn:aws:ecr:us-east-1:${data.aws_caller_identity.current.account_id}:repository/amiasea-*"
    ]
  }

  statement {
    sid    = "CodeArtifactRepositoryManagement"
    effect = "Allow"

    actions = [
      "codeartifact:CreateRepository",
      "codeartifact:DescribeRepository",
      "codeartifact:ListTagsForResource",
      "codeartifact:UpdateRepository",
      "codeartifact:DeleteRepository",
      "codeartifact:TagResource",
      "codeartifact:UntagResource",
    ]

    resources = [
      "arn:aws:codeartifact:us-east-1:${data.aws_caller_identity.current.account_id}:repository/amiasea/*"
    ]
  }
}

data "aws_iam_policy_document" "pomology_artifact_role_boundary" {
  statement {
    sid       = "CodeArtifactAuthorization"
    effect    = "Allow"
    actions   = ["codeartifact:GetAuthorizationToken"]
    resources = [
      "arn:aws:codeartifact:us-east-1:${data.aws_caller_identity.current.account_id}:domain/amiasea"
    ]
  }

  statement {
    sid       = "CodeArtifactServiceBearerToken"
    effect    = "Allow"
    actions   = ["sts:GetServiceBearerToken"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "sts:AWSServiceName"
      values   = ["codeartifact.amazonaws.com"]
    }
  }

  statement {
    sid    = "CodeArtifactRepositoryAccess"
    effect = "Allow"
    actions = [
      "codeartifact:DescribeRepository",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ListPackages",
      "codeartifact:ReadFromRepository",
      "codeartifact:PublishPackageVersion",
      "codeartifact:PutPackageMetadata",
      "codeartifact:DescribePackageVersion",
      "codeartifact:GetPackageVersionReadme",
      "codeartifact:ListPackageVersionAssets",
      "codeartifact:ListPackageVersionDependencies",
      "codeartifact:ListPackageVersions",
    ]

    resources = [
      "arn:aws:codeartifact:us-east-1:${data.aws_caller_identity.current.account_id}:repository/amiasea/amiasea-*",
      "arn:aws:codeartifact:us-east-1:${data.aws_caller_identity.current.account_id}:package/amiasea/amiasea-*/*/*/*",
    ]
  }

  statement {
    sid       = "ECRAuthorization"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "ECRRepositoryAccess"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = [
      "arn:aws:ecr:us-east-1:${data.aws_caller_identity.current.account_id}:repository/amiasea-*"
    ]
  }
}

resource "aws_iam_policy" "pomology_artifact_role_boundary" {
  name        = "amiasea-pomology-artifact-role-boundary"
  description = "Maximum permissions for pomology-specific artifact publish and restore roles."
  policy      = data.aws_iam_policy_document.pomology_artifact_role_boundary.json
}

resource "aws_iam_role_policy" "pomology_propagation_role_permissions" {
  name   = "pomology-propagation-permissions"
  role   = aws_iam_role.pomology_propagation_role.id
  policy = data.aws_iam_policy_document.pomology_propagation_role_permissions.json
}

resource "aws_iam_role" "pomology_propagation_role" {
  name                 = "amiasea-pomology-propagation"
  description          = "Execution role for the HCP Terraform enterprise pomology propagation Stack."
  assume_role_policy   = data.aws_iam_policy_document.pomology_propagation_role_trust.json
  max_session_duration = 3600
}
