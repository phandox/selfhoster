module "doks" {
  source                        = "nlamirault/doks/digitalocean"
  version                       = "1.0.0"
  auto_scale                    = true
  auto_upgrade                  = true
  cluster_name                  = var.cluster_name
  kubernetes_version            = var.k8s_version_prefix
  maintenance_policy_day        = "monday"
  maintenance_policy_start_time = "13:00" # UTC
  node_count                    = "1"
  min_nodes                     = "1"
  max_nodes                     = "3"
  region                        = var.region
  size                          = var.size
  vpc_uuid                      = var.vpc_uuid
  tags                          = var.tags
}