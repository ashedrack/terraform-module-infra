module "compute" {
  source        = "../../modules/compute"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  tags          = var.tags
}
