locals {
  kubernetes_version  = "1.33.3"
  node_pool_name      = "agentpool"
  node_vm_size        = "Standard_DS2_v2"
  node_count          = 2
  log_retention_days  = 30
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

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = local.node_pool_name
    vm_size    = local.node_vm_size
    node_count = local.node_count
  }

  network_profile {
    network_plugin = "azure"
  }

  tags = {
    environment = var.environment
  }

  depends_on = [azurerm_log_analytics_workspace.law]
}
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
