resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags      = var.tags
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  tags              = var.tags
}
