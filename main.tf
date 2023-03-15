module "provider_module" {
  source = "./modules/provider"
  aws_profile = "default"
  aws_region = "us-east-2"
}