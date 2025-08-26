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
    owner = "victor"
    project = "mibanco"
  }
}

