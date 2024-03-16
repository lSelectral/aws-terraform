variable "region" {
  type     = string
  nullable = false
  description = "The AWS region to deploy to. Must be one of us-central-1, eu-central-1, ap-south-1, sa-east-1, ca-central-1"
  validation {
    condition     = can(regex("^(us|eu|ap|sa|ca)-(central|east|west|south|north)-[0-9]$", var.region))
    error_message = "Invalid region"
  }
  default = "eu-central-1"
}

# variable "s3_name" {
#   type = string
#   description = "The name of the S3 bucket to create"
#   validation {
#     condition     = length(var.s3_name) > 3
#     error_message = "Bucket name must be at least 3 characters long"
#   }
#   nullable = false
# }

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
  nullable = false
}

variable "availability_zone1" {
  type = string
  description = "The availability zone to deploy to in the selected region EC2"
  default = "eu-central-1a"
  nullable = false
}

variable "availability_zone2" {
  type = string
  description = "The availability zone to deploy to in the selected region EC2"
  default = "eu-central-1b"
  nullable = false
}

variable "route_cidr_block" {
  type = string
  description = "The CIDR block for the route"
  default = "0.0.0.0/0" # Allow all traffic
  nullable = false
}