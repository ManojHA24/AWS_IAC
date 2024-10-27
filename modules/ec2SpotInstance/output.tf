output "spot_ec2_pip" {
  value = aws_spot_instance_request.vps.public_ip
}