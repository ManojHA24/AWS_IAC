variable "instance_type" {
  type = string
}
variable "ami" {
  type = string
}
variable "security_group_ids" {
  type = list(string)
}
variable "subnet_id" {
  type = string
}
variable "spot_price" {
  type = string
}
variable "spot_type" {
  type = bool
}
variable "deploy" {
  type = string
}