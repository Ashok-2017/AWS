resource "aws_ecs_cluster" "test1" {
  name = "test1-staging"
  capacity_providers = ["FARGATE"]
  
  tags {
    environment = "staging"
  }
}
