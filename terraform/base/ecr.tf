resource "aws_ecr_repository" "go_serverless_api_repository" {
  name                 = "${var.project_name}-${var.environment}-go-serverless-api-repository"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "go_serverless_apirepository_delete_policy" {
  repository = aws_ecr_repository.go_serverless_api_repository.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}