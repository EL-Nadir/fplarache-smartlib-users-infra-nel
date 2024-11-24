output "ecr_repository_url" {
  value = aws_ecr_repository.users_repo_nadir.repository_url
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.users_cluster_nadir.id
}

output "ecs_service" {
    value = aws_ecs_service.users_service_nadir.name
}