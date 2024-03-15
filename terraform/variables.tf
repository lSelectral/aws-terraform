variable "region" {
  type = string
  nullable = false
  validation {
    condition = can(regex("^(us|eu|ap|sa|ca)-(central|east|west|south|north)-[0-9]$", var.region))
    error_message = "Invalid region"
  }
  default = "eu-central-1"
}

variable "s3_name" {
  type = string
  validation {
    condition = length(var.s3_name) > 3
    error_message = "Bucket name must be at least 3 characters long"
  }
  nullable = false
}
