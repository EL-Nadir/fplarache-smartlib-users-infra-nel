output "ecr_repository_url" {
  description = "The URL of the Elastic Container Registry (ECR) repository"
  value       = aws_ecr_repository.users_repo_nadir.repository_url
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.users_cluster_nadir.id
}

output "ecs_service" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.users_service_nadir.name
}
