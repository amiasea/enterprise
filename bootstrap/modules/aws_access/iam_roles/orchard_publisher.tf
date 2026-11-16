resource "aws_iam_role" "orchard_publisher" {
  name               = "orchard-publisher"
  assume_role_policy = var.assume_role_policy
}