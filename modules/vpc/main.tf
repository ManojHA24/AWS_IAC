resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_address_block
}