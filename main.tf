provider "aws" {
  region = var.aws_region
}

# Create an ECR Repository
resource "aws_ecr_repository" "users_repo_nadir" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
}

# Create an ECS Cluster
resource "aws_ecs_cluster" "users_cluster_nadir" {
  name = var.ecs_cluster_name
}

# Create an ECS Task Definition
resource "aws_ecs_task_definition" "users_td_nadir" {
  family                   = var.ecs_task_family
  container_definitions    = <<DEFINITION
  [
    {
      "name": "users_container_nadir",
      "image": "${aws_ecr_repository.users_repo_nadir.repository_url}:latest",
      "memory": ${var.container_memory},
      "cpu": ${var.container_cpu},
      "essential": true
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "${var.container_memory}"
  cpu                      = "${var.container_cpu}"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

# Create an ECS Service
resource "aws_ecs_service" "users_service_nadir" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.users_cluster_nadir.id
  task_definition = aws_ecs_task_definition.users_td_nadir.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  desired_count = 1
}

# Define an IAM Role for ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role_nadir"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
