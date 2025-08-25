variable "aws_region"   { type = string }
variable "cidr_block"   { type = string }
variable "global_tags" {
  type = map(string)
  validation {
    condition = contains(keys(var.global_tags), "Owner")
            && contains(keys(var.global_tags), "CostCenter")
            && contains(keys(var.global_tags), "Project")
            && contains(keys(var.global_tags), "Env")
    error_message = "global_tags must include Owner, CostCenter, Project and Env."
  }
}
variable "demo_message" {
  type        = string
  default     = "Hello ACME - IaC OK (Ubuntu)"
  description = "Mensagem exibida na página inicial do Apache"
}

