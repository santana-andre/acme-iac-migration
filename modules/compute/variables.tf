variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }
variable "instance_type" { type = string }
variable "user_data" { type = string }
variable "tags" { type = map(string) }
