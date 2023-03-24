terraform {
  backend "s3" {}
}
module "provider_module" {
  source      = "./modules/provider"
  aws_profile = "default"
  aws_region  = "us-east-2"
}
module "network_module" {
  source      = "./modules/network"
  vpc_cidr    = "10.0.0.0/20"
  subnet_cidr = "10.0.1.0/24"
  subnet_az   = "us-east-2a"
}
module "ec2_module" {
  depends_on = [
    module.network_module
  ]
  source                = "./modules/ec2"
  webserver_ami         = "ami-00eeedc4036573771"
  webserver_intanceType = "t2.micro"
  webserver_vpc_id      = module.network_module.vpc_output.id
  webserver_subnet_id   = module.network_module.subnet_output.id
  instance_az           = "us-east-2a"
  private_ip_id         = "10.0.1.50"
  igw_res               = module.network_module.igw_output
  pem_key               = "ansible"
}
