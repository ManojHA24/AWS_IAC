resource "aws_subnet" "snet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.snet_cidr
  availability_zone = var.snet_availability_zone
}