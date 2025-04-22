variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = { Name = "prod-ec2-instance" }
}
