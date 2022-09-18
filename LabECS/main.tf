resource "aws_ecr_repository" "ecr-terraform-repository" {
  name                 = "ecr-terraform-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "ecr_${var.owner}_lab_ecs"
    Owner       = var.owner
    Department  = var.department
    Environment = var.environment
  }
}

resource "aws_ecr_repository_policy" "ecr-repo-policy" {
  repository = aws_ecr_repository.ecr-terraform-repository.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

resource "aws_ecs_cluster" "main" {
  name = "${var.owner}-cluster-${var.environment}"
}

resource "aws_ecs_task_definition" "ecs-task" {
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  family                = "ecs-ian"
  container_definitions = <<TASK_DEFINITION
[
  {
    "cpu": 10,
    "environment": [],
    "essential": true,
    "image": "${var.container_image}",
    "name": "nginx_app",
    "portMappings": [
      {
        "containerPort": ${var.container_port},
        "hostPort": ${var.container_port}
      }
    ]
  }
]
TASK_DEFINITION
}

resource "aws_ecs_service" "ecs-service" {
 name                               = "${var.owner}-service-${var.environment}"
 cluster                            = aws_ecs_cluster.main.id
 task_definition                    = aws_ecs_task_definition.ecs-task.arn
 desired_count                      = var.desired_count_service
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.ecs_tasks.id]
   subnets          = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
   assign_public_ip = false
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.main.id
   container_name   = "nginx_app"
   container_port   = var.container_port
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}
