resource "aws_ecr_repository" "kvs-dg-trigger" {
  name                 = "kvs-dg-trigger"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "kvs-dg-integrator" {
  name                 = "kvs-dg-integrator"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}