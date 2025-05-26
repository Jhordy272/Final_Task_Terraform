# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create a Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Call the network module
module "network" {
  source              = "./modules/network"
  vpc_id              = aws_vpc.vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

# Call the compute module
module "compute" {
  depends_on             = [module.network]
  source                 = "./modules/compute"
  aws_subnet_id          = module.network.private_subnet_id
  aws_security_group_ids = module.network.security_groups_ids
  instance_count         = 2
}

# module "compute_public" {
#   depends_on             = [module.network]
#   source                 = "./modules/compute"
#   aws_subnet_id          = module.network.public_subnet_id
#   aws_security_group_ids = module.network.security_groups_ids
#   instance_count         = 1
# }

# Attach the EC2 instances to the ELB
resource "aws_elb_attachment" "elb_attachment" {
  count    = length(module.compute.instance_ids)
  elb      = module.network.elb_name
  instance = module.compute.instance_ids[count.index]
}