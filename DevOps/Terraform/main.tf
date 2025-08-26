module "resource_group" {
  source       = "./modules/resource_group"
  environment  = var.environment
  iteration_rg = var.iteration_rg
  location     = var.location
  tags = {
    owner   = "victor"
    project = "mibanco"
  }
}

module "acr" {
  source              = "./modules/container_registry"
  environment         = var.environment
  iteration_rg        = var.iteration_rg
  resource_group_name = module.resource_group.rg_name
  location            = var.location
  sku                 = "Basic"
  tags = {
    owner   = "victor"
    project = "mibanco"
  }
}

module "aks" {
  source              = "./modules/aks"
  environment         = var.environment
  iteration_rg        = var.iteration_rg
  resource_group_name = module.resource_group.rg_name
  location            = var.location
  aks_default_node = {
    name       = "default"
    size       = "standard_d2als_v6"
    node_count = 1
  }
  aks_authorize_ip_list = [
    "191.98.183.18/32",
    "179.6.35.114/32",
  ]
  tags = {
    owner   = "victor"
    project = "mibanco"
  }
}
