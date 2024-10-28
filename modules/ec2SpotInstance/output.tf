output "spot_ec2_pip" {
  value = var.deploy == true ? aws_spot_instance_request.vps[0].public_ip : ""
}