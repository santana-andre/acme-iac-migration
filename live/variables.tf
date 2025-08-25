variable "aws_region"   { type = string }
variable "cidr_block"   { type = string }
variable "global_tags"  { type = map(string) }
variable "demo_message" {
  type        = string
  default     = "Hello ACME - IaC OK (Ubuntu)"
  description = "Mensagem exibida na página inicial do Apache"
}

