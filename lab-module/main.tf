module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "ec2" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
  ami_id        = "ami-0a0b0b06dd1636865" # Amazon Linux 2
  subnet_id     = module.vpc.subnet_id
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "my-terraform-bucket-841226"
}

