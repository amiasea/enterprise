data "aws_iam_policy_document" "solution_actualization_role_trust" {
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
      values   = var.solution_actualization_stack_subject_identifiers
    }
  }
}

resource "aws_iam_role" "solution_actualization_role" {
  name                 = "amiasea-solution-actualization"
  description          = "Execution role for the HCP Terraform enterprise solution actualization Stack."
  assume_role_policy   = data.aws_iam_policy_document.solution_actualization_role_trust.json
  max_session_duration = 3600
}