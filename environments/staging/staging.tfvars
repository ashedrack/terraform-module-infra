ami_id            = "ami-05572e392e80aee89"
vpc_cidr          = "10.1.0.0/16" # Different VPC CIDR for staging
subnet_cidr       = "10.1.1.0/24" # Different subnet CIDR for staging
availability_zone = "us-west-2a"
instance_type     = "t2.micro"

tags = {
  Name        = "staging-ec2-instance"
  Environment = "staging"
}
