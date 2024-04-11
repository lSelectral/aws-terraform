# Task Definition

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  name       = "ecs-task-execution-role-policy-attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = "my-ecs-task"
  network_mode       = "awsvpc" # This tells the ECS cluster to use the VPC networking we have defined in the “VPC setup” section
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  cpu                = 256 # The amount of CPU units to reserve for the task

  # Since we are using Amazon Linux AMI for our EC2 instances, the operating_system_family is specified as “LINUX,” 
  # and the CPU architecture is set as “X86_64”. If this information is incorrect, the ECS tasks enter in the constant restart loop
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "dockergs"
      image     = "public.ecr.aws/f9n5f1l7/dgs:latest" # Image URL of the application image
      cpu       = 256                                  # The amount of CPU units to reserve for the container
      memory    = 512                                  # The amount of memory (in MiB) to reserve for the container
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}