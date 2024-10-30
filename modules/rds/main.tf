resource "aws_db_subnet_group" "default" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids # List of subnet IDs for the RDS instance
}

resource "aws_db_instance" "default" {
  identifier              = "mydbinstance"
  allocated_storage       = 20  # Size in GB
  engine                 = "mysql" # Change to your desired database engine (mysql, postgres, etc.)
  engine_version         = "8.0"   # Specify the version of the database engine
  instance_class         = "db.t3.micro" # Change as needed
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.default.id] # Change to your security group ID
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  skip_final_snapshot    = true  # Set to false if you want a final snapshot when deleting the DB
  multi_az               = false  # Change to true for Multi-AZ deployments
}