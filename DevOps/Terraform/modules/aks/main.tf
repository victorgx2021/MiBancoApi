resource "azurerm_kubernetes_cluster" "kubernetes" {
  name                = "aks-${var.workload}-${var.environment}-${coalesce(var.iteration, var.iteration_rg)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = "aks-${var.workload}-${var.environment}-${coalesce(var.iteration, var.iteration_rg)}-dns"

  default_node_pool {
    name                  = var.aks_default_node.name
    vm_size               = var.aks_default_node.size
    node_count            = var.aks_default_node.node_count

    auto_scaling_enabled  = false
    node_labels           = merge(tomap({
      "type" = "linux",
      source = "terraform",
      type = "application",
      default_node = "true",
      environment = var.environment
    }), var.tags)
    type                  = "VirtualMachineScaleSets"
    node_public_ip_enabled = false
    temporary_name_for_rotation = "temporary"
    tags                  = merge(var.tags, {
      source = "terraform",
      type = "application",
      default_node = "true",
      environment = var.environment
    })
    max_pods              = 250
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].upgrade_settings
    ]
  }

  tags     = merge(var.tags, {
    source = "terraform",
    type = "application",
    environment = var.environment
  })

  dynamic "api_server_access_profile" {
    for_each = length(var.aks_authorize_ip_list) > 0 ? [1] : []
    content {
      authorized_ip_ranges = var.aks_authorize_ip_list
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
  }

  image_cleaner_enabled = true
  image_cleaner_interval_hours = 168
}

resource "azurerm_kubernetes_cluster_node_pool" "other_nodes" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes.id
  auto_scaling_enabled  = false
  node_public_ip_enabled = false
  max_pods = 250

  for_each = { for f_node in var.aks_other_nodes : f_node.name => f_node}
  name                  = each.value.name
  vm_size               = each.value.size
  node_count            = each.value.node_count
  mode = each.value.mode

  node_labels           = merge(tomap({
    "type" = "linux",
    source = "terraform",
    type = "application",
    default_node = "true",
    environment = var.environment
  }), var.tags)

  tags                  = merge(var.tags, {
    source = "terraform",
    type = "application",
    default_node = "false",
    environment = var.environment
  })

  depends_on = [azurerm_kubernetes_cluster.kubernetes]
}
