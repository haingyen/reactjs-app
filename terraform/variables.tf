# VARIABLES
variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "public_subnet_ids" {
  default = [
    "subnet-09209e4d47bfdb50d",
    "subnet-08dd699b60bdf7c40",
    "subnet-0aa79bb707acbf4ba"
  ]
}