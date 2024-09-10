# TODO: Add optional custom KMS key for ECR
#tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "serverless_wordpress" {
  name = "${var.site_name}-serverless-wordpress"
  # TODO: Investigate enforcing immutability on tags
  #tfsec:ignore:aws-ecr-enforce-immutable-repository
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    # TODO: Make ECR scan on push optional in future
    #tfsec:ignore:aws-ecr-enable-image-scans
    scan_on_push = false
  }
}
