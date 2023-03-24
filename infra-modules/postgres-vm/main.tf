locals {
  instances = [for idx in range(var.instance_count) : format("psql-vm-%s-%s-%03d", var.region, var.env, idx + 1)]
}

resource "digitalocean_tag" "psql-fw" {
  name = "psql-fw-${var.env}"
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
  tags       = concat([digitalocean_tag.psql-fw.id, var.env], var.tags)
  vpc_uuid   = var.vpc.id
  user_data  = file("startup-script.yaml")
}

resource "digitalocean_firewall" "db-fw" {
  name = "allow-psql-${var.env}"
  tags = [digitalocean_tag.psql-fw.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "5432"
    source_addresses = [var.vpc.ip_range]
  }
}

resource "digitalocean_volume_attachment" "persistent-volume" {
  count      = var.volume_id != null ? 1 : 0
  droplet_id = digitalocean_droplet.psql-vm[local.instances[0]].id
  volume_id  = var.volume_id
}
