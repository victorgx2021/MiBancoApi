resource "azurerm_container_registry" "container_registry" {
  name = "cr${var.workload}${var.environment}${coalesce(var.iteration, var.iteration_rg)}"
  resource_group_name = var.resource_group_name
  location = var.location
  admin_enabled = true
  sku = var.sku

  tags     = merge(var.tags, {
    source = "terraform",
    type = "data",
    environment = var.environment
    location = var.location
  })
}
