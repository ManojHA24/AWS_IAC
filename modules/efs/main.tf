resource "aws_efs_file_system" "efs" {}

module "efs_access_point" {
  source = "./accessPoint"

  efs_id = aws_efs_file_system.efs.id
}