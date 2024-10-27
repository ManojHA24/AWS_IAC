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
variable "nic_id" {
  type = string
}
variable "deploy" {
  type = bool
}
variable "key_pair_name" {
  type = string
}