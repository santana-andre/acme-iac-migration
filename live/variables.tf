variable "aws_region"   { type = string }
variable "cidr_block"   { type = string }
variable "global_tags" {
  description = "Tags obrigatórias aplicadas a todos os recursos"
  type        = map(string)

  # exige que Owner, CostCenter, Project e Env existam e não estejam vazios
  validation {
    condition = alltrue([
      for k in ["Owner", "CostCenter", "Project", "Env"] :
      length(trim(lookup(var.global_tags, k, ""))) > 0
    ])
    error_message = "global_tags must include non-empty Owner, CostCenter, Project and Env."
  }
}
variable "demo_message" {
  type        = string
  default     = "Hello ACME - IaC OK (Ubuntu)"
  description = "Mensagem exibida na página inicial do Apache"
}

