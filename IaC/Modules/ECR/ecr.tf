module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.2"

  repository_name = var.name

  repository_force_delete         = true // ToDo: Remove in a real environment
  repository_image_scan_on_push   = false
  attach_repository_policy        = false
  repository_image_tag_mutability = "MUTABLE"

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 10
        },
        action = {
          type = "expire"
        }
      },
      {
        "rulePriority" : 2,
        "description" : "Expire images older than 1 day",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 1
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })

  tags = merge(var.default_tags,
    {
      description = "This ECR contains the images of the challenge"
  })
}
