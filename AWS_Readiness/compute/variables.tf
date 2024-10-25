variable "location" {
  type = string
}
variable "security_groups" {
  type = list(string)
}
variable "spot_instance" {
  type = bool
}