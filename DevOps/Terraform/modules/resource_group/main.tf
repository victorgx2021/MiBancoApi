resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.workload}-${var.environment}-${var.iteration_rg}"
  location = var.location
  tags     = merge(var.tags, {
    source = "terraform",
    environment = var.environment,
    location = var.location
  })
}
