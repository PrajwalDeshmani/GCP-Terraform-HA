module "network" {
  source = "./modules/network"

  project_id = var.project_id
}

module "compute_primary" {
  source = "./modules/compute"

  region = var.primary_region
  zones  = var.zones_primary
  name   = "primary"
  network = module.network.network_self_link
}

module "compute_secondary" {
  source = "./modules/compute"

  region = var.secondary_region
  zones  = var.zones_secondary
  name   = "secondary"
  network = module.network.network_self_link
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  instance_group_1 = module.compute_primary.instance_group
  instance_group_2 = module.compute_secondary.instance_group
}
