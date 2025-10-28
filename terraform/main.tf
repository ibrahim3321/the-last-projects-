 module "resourcegroups" {
   source                  = "./modules/resourcegroups"
   resource_group_name     = var.resource_group_name
   resource_group_location = var.resource_group_location
   author                  = var.author
 } 
 module "aks" {
   source                  = "./modules/aks"
   resource_group_name     = module.resourcegroups.resource_group_name
   resource_group_location = module.resourcegroups.resource_group_location
   resource_prefix         = var.resource_prefix
   environment             = var.environment 
   acr_id                  = var.acr_id  
 }

 module "disk" {
   source                    = "./modules/disk"
   resource_group_name       = module.resourcegroups.resource_group_name
   resource_group_location   = module.resourcegroups.resource_group_location
   azurerm_resource_group_id = module.resourcegroups.resource_group_id
   managed_disk_name         = var.managed_disk_name
   disk_size_gb              = var.disk_size_gb
   storage_account_type      = var.storage_account_type
   environment               = var.environment
   resource_prefix           = var.resource_prefix
   aks_resource_group_name   = module.resourcegroups.resource_group_name
   aks_cluster_name          = local.aks_cluster_name
   aks_principal_id          = module.aks.aks_principal_id
   depends_on = [module.aks, module.resourcegroups]
 }
