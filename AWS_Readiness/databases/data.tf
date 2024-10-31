data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["valnix-vpc-useast-1"]
  }
}

data "aws_subnet" "db_subnet" {
  filter {
    name   = "tag:Name"
    values = ["snet-db-01"]
  }
}