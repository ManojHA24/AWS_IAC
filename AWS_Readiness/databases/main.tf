module "security_group" {
  source = "../../modules/vpc/securityGroups"

  security_grp_name = "DB_Inbound"
  vpc_id            = data.aws_vpc.vpc.id
}

module "rds" {
  source = "../../modules/rds"

  rds_engine                 = "postgres"
  db_compute_instance        = "db.t3.micro"
  skip_create_final_snapshot = true
  db_name                    = "test"
  db_password                = "DafaqsGoinon@123"
  db_username                = "iamadmin"
  subnet_ids                 = [data.aws_subnet.db_subnet.id]
  security_group_ids         = [module.security_group.sg_id]
  multi_availability_zones   = false
  allocated_storage          = 100

  db_subnet_group_name = "valnix-rds-subnet-group"
}