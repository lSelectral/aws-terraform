# ALB (Application Load Balancer)

locals {
  alb_name          = "ecs-alb"     # Name of the ALB
  is_internal       = false         # Set to true if the ALB is internal
  type              = "application" # Type of the ALB - application or network
  port              = 80
  protocol          = "HTTP"
  target_group_name = "ecs-target-group"
}

resource "aws_lb" "ecs_alb" {
  name               = local.alb_name
  internal           = local.is_internal
  load_balancer_type = local.type
  security_groups    = [aws_security_group.security_group.id]
  subnets            = [aws_subnet.subnet.id, aws_subnet.subnet2.id]

  tags = {
    Name = "ecs-alb"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = local.port
  protocol          = local.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = local.target_group_name
  port        = local.port
  protocol    = local.protocol
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path = "/"
  }
}
