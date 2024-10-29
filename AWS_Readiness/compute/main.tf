module "vpc" {
  source = "../../modules/vpc"

  vpc_address_block = "10.0.0.0/16"
}

module "subnet" {
  source = "../../modules/vpc/subnet"

  vpc_id                 = module.vpc.vpc_id
  snet_availability_zone = "us-east-1a"
  snet_cidr              = "10.0.1.0/24"
}

module "security_group" {
  source = "../../modules/vpc/securityGroups"

  security_grp_name = "SSH_Inbound"
  vpc_id            = module.vpc.vpc_id
}

module "internet_gateway" {
  source = "../../modules/vpc/internetGateway"

  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "../../modules/vpc/routeTable"

  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.subnet.subnet_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
}

# resource "aws_network_interface" "my_network_interface" {
#   subnet_id   = module.subnet.subnet_id
#   private_ips = ["10.0.1.10"]  # Specify a private IP if needed
# }

module "key_Pair" {
  source = "../../modules/keyPair"

  key_pair_name = var.key_pair_name
}

module "ec2" {
  source = "../../modules/ec2"
  deploy = var.spot_instance == false ? false : true

  instance_type      = "t2.micro"
  ami                = "ami-0866a3c8686eaeeba"
  security_group_ids = [module.security_group.sg_id]
  subnet_id          = module.subnet.subnet_id
  #   nic_id = aws_network_interface.my_network_interface.id
  key_pair_name = module.key_Pair.aws_key_pair_name
  associate_pip = true
}

module "ec2_spot" {
  source = "../../modules/ec2SpotInstance"
  deploy = var.spot_instance == true ? true : false

  instance_type      = "t2.micro"
  ami                = "ami-0c55b159cbfafe1f0"
  spot_price         = "0.03"
  spot_type          = "persistent"
  security_group_ids = module.security_group.sg_id
  subnet_id          = module.subnet.subnet_id
  key_pair_name      = module.key_Pair.aws_key_pair_name
}

module "ebs" {
  source = "../../modules/ebs"

  ebs_size = var.ebs_size
  ec2_availability_zone = module.ec2_spot.spot_ec2_availability_zone
  multi_attach_enabled = var.multi_attach_enabled
}

module "ebs_vol_attach" {
  source = "../../modules/ebs/ebs_volume_attach"

  ec2_id = module.ec2_spot.spot_ec2_id
  volume_id = module.ebs.id
  depends_on = [ module.ebs ]

}
# module "efs" {
#   source = "../../modules/efs"

#   security_group_id = module.security_group.sg_id
#   subnet_id         = module.subnet.subnet_id
# }

# resource "null_resource" "configure_nfs" {
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = module.key_Pair.aws_key_pem
#     host        = var.spot_instance == true ? module.ec2_spot.spot_ec2_pip : module.ec2.ec2_public_ip
#   }
#   provisioner "remote-exec" {
#     inline = [

#       "sudo apt-get update -y",
#       "sudo mkdir -p /mnt/nixstore",
#       "sudo mount -t efs -o tls,accesspoint=${module.efs.access_point_id} ${module.efs.efs_id}:/ ${var.access_point_mount_point}"
#     ]
#   }
# }