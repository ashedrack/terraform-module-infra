ami_id = "ami-05572e392e80aee89"
vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
availability_zone = "us-west-2a"
instance_type = "t2.micro"

tags = {
  Name = "dev-ec2-instance"
  Environment = "dev"
}
