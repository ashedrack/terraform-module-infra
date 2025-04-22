module "network" {
  source            = "../../modules/network"
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  tags              = var.tags
}

module "compute" {
  source        = "../../modules/compute"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.network.subnet_id
  tags          = var.tags
}
