variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "eu-north-1"
}

variable "ecr_repository_name" {
  description = "The name of the Elastic Container Registry (ECR) repository"
  default     = "dev-fplarache-smartlib-users-repo-nadir"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "dev-fplarache-smartlib-users-cluster-nadir"
}

variable "ecs_task_family" {
  description = "The family name of the ECS task definition"
  default     = "dev-fplarache-smartlib-users-td-nadir"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  default     = "dev-fplarache-smartlib-users-service-nadir"
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS service networking"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for ECS service networking"
  type        = list(string)
}

variable "container_memory" {
  description = "The memory (in MiB) allocated to the container"
  default     = 512
}

variable "container_cpu" {
  description = "The amount of CPU units allocated to the container"
  default     = 256
}
