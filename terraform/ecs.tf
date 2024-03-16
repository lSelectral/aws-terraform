# ECS

locals {
  image_id = "ami-062c116e449466e7f" # Amazon Linux 2
  instance_type = "t3.micro" # Free tier eligible - 1 vCPU, 1GB RAM
  volume_size = 30 # GB
  volume_type = "gp2" # General Purpose SSD
}

resource "aws_launch_template" "ecs_lt" {
 name_prefix   = "ecs-template"
 image_id      = local.image_id
 instance_type = local.instance_type

 vpc_security_group_ids = [aws_security_group.security_group.id]
 iam_instance_profile {
   name = "ecsInstanceRole"
 }

 block_device_mappings {
   device_name = "/dev/xvda"
   ebs {
     volume_size = local.volume_size
     volume_type = local.volume_type
   }
 }

 tag_specifications {
   resource_type = "instance"
   tags = {
     Name = "ecs-instance"
   }
 }

 user_data = filebase64("${path.module}/ecs.sh")
}