module "vpc" {
	source = "../../modules/vpc"

	vpc_address_block = "10.0.0.0/16"
}

module "subnet" {
  source = "../../modules/vpc/subnet"

	vpc_id = module.vpc.vpc_id
	snet_availability_zone = "us-east-1a"
	snet_cidr = "10.0.1.0/24"
}

module "security_group" {
	source = "../../modules/vpc/securityGroups"

	security_grp_name = "SSH_Inbound"
	vpc_id = module.vpc.vpc_id
}

resource "aws_network_interface" "my_network_interface" {
  subnet_id   = module.subnet.subnet_id
  private_ips = ["10.0.1.10"]  # Specify a private IP if needed
}

module "ec2" {
  source = "../../modules/ec2"

  instance_type = "t2.micro"
  ami = "ami-0c55b159cbfafe1f0"
  security_group_ids = module.security_group.sg_id
  subnet_id = module.subnet.subnet_id
	nic_id = aws_network_interface.my_network_interface.id
}