variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}
variable "availability_zone_names" {
  type    = string
  default = "us-west-1a"
}
variable "keypair" {
  type        = string
  description = "The aliaa keypair of the machine server."
}
