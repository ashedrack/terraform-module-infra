ami_id      = "ami-0c55b159cbfafe1f0" # Example AMI ID, replace with a valid one for your region
subnet_id   = "subnet-xxxxxxxx"         # Replace with your subnet ID
instance_type = "t2.micro"
tags = {
  Name = "staging-ec2-instance"
  Environment = "staging"
}
