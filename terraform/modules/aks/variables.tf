variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "resource_prefix" {
  type = string
}
variable "environment" {
  type = string
}


variable "acr_id" {
  type    = string
  default = ""
}


variable "enable_oidc" {
  type    = bool
  default = true
}   
variable "enable_monitoring" {
  type    = bool
  default = true
}  
variable "enable_agw_ingress" {
  type    = bool
  default = false
} 
variable "appgw_subnet_id" {
  type    = string
  default = ""
}
variable "appgw_id" {
  type    = string
  default = ""
}
