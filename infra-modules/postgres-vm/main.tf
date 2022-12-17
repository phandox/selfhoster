locals {
  instances = [for idx in range(var.instance_count) : format("psql-vm-%s-%03d", var.region, idx + 1)]
}

resource "digitalocean_tag" "psql-fw" {
  name = "psql-fw"
}
resource "digitalocean_droplet" "psql-vm" {
  for_each   = toset(local.instances)
  image      = "ubuntu-22-04-x64"
  name       = each.value
  region     = var.region
  size       = var.instance_size
  backups    = false
  monitoring = true
  ssh_keys   = var.ssh_keys
  tags       = concat([digitalocean_tag.psql-fw.id], var.tags)
  vpc_uuid   = var.vpc.id
}

resource "digitalocean_firewall" "db-fw" {
  name = "allow-psql"
  tags = [digitalocean_tag.psql-fw.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "5431"
    source_addresses = [var.vpc.ip_range]
  }
}