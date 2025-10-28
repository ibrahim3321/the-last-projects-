locals {
  kubernetes_version = "1.33.3"
  node_pool_name     = "agentpool"
  node_vm_size       = "Standard_D2s_v6"
  node_count         = 2
  log_retention_days = 30
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.resource_prefix}-law"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = local.log_retention_days
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.resource_prefix}-aks"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.resource_prefix}-dns"
  kubernetes_version  = local.kubernetes_version

 
  identity { type = "SystemAssigned" }

  default_node_pool {
    name       = local.node_pool_name
    vm_size    = local.node_vm_size
    node_count = local.node_count
   
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    # network_policy  = "azure"  # if you use Azure CNI + NP
  }


  oidc_issuer_enabled       = var.enable_oidc
  workload_identity_enabled = var.enable_oidc

  
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
    # enabled is implied when ID is set on newer providers
  }

  
  dynamic "ingress_application_gateway" {
    for_each = var.enable_agw_ingress ? [1] : []
    content {
      # Pick exactly one of the following, based on your design:
      subnet_id            = length(var.appgw_subnet_id) > 0 ? var.appgw_subnet_id : null
      gateway_id           = length(var.appgw_id)        > 0 ? var.appgw_id        : null
    }
  }

  tags = { environment = var.environment }

  depends_on = [azurerm_log_analytics_workspace.law]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  count                = length(var.acr_id) > 0 ? 1 : 0
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id

  
  skip_service_principal_aad_check = true
}
