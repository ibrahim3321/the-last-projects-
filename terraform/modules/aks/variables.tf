variable "resource_group_name" {}
variable "resource_group_location" {}
variable "resource_prefix" {}
variable "environment" {}

# ACR the cluster should pull from
variable "acr_id" {
  type = string
}

# AGIC controls
variable "enable_agic" {
  type    = bool
  default = true
}

# If true, AKS will create an AppGW in a managed MC_* RG and carve a subnet for it
variable "appgw_subnet_cidr" {
  type    = string
  default = "10.225.0.0/24"
}

# Name for the managed App Gateway (created by AKS when using subnet_cidr)
variable "appgw_name" {
  type    = string
  default = null
}
