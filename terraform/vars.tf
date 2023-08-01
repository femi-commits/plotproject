variable "aws_profile" {
  type        = string
  description = "AWS profile"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "key_pair" {
  type        = string
  description = "SSH key path"
}


variable "ssh_port" {
  description = "The SSH port to open in the security group."
  type        = number
  default     = 22
}

variable "plotly_port" {
  description = "The application port to open in the security group."
  type        = number
  default     = 5000
}
