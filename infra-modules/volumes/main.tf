resource "digitalocean_volume" "volume" {
  name                     = var.name
  region                   = var.region
  size                     = var.size
#  initial_filesystem_type  = "ext4"
#  initial_filesystem_label = var.fs_label
  tags                     = concat(var.tags, [var.env])
}

output "volume_id" {
  value = digitalocean_volume.volume.id
}
