# VARIABLES
variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "subnet_ids" {
  default = [
    "subnet-0f8ef88298f686483",  
    "subnet-0639368dd7ead526f",  
    "subnet-0356a0b5e39cd1562"  
  ]
}