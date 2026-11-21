variable "aws_region" {
  description = "AWS region for the CI/CD demo"
  type        = string
  default     = "ap-south-1"
}
variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "allowed_cidr" {
  description = "Your public IPv4 address in CIDR notation"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.allowed_cidr))
    error_message = "Provide a valid IPv4 CIDR range."
  }

}

