ami_id            = "ami-05572e392e80aee89"
vpc_cidr          = "10.2.0.0/16"          # Different VPC CIDR for prod
subnet_cidr       = "10.2.1.0/24"          # Different subnet CIDR for prod
availability_zone = "us-west-2a"
instance_type     = "t2.micro"

tags = {
  Name        = "prod-ec2-instance"
  Environment = "prod"
}
