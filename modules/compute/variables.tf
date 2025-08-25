variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }
variable "instance_type" { type = string }
variable "user_data" { type = string }
variable "tags" { type = map(string) }
variable "demo_message" {
  type        = string
  default     = "Hello ACME - IaC OK (Ubuntu)"
  description = "Mensagem exibida na página inicial do Apache"
}

