variable "vpc_id" {
  description = "VPC onde os recursos de compute serão criados"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet pública onde a instância ficará"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2 (ex.: t2.micro)"
  type        = string
}

variable "tags" {
  description = "Mapa de tags padrão aplicado a todos os recursos"
  type        = map(string)
}

variable "demo_message" {
  description = "Mensagem exibida no HTML da página inicial"
  type        = string
  default     = "Hello ACME - IaC OK (Ubuntu)"
}
