variable "name" {
  type        = string
  description = "Name of network volume"
}
variable "region" {
  type        = string
  default     = "fra1"
  description = "Region of network volume. Must match droplet"
}
variable "size" {
  default     = 1
  type        = number
  description = "Volume size in GiB"
}

variable "fs_label" {
  default     = "example"
  type        = string
  description = "Filesystem label for volume, useful for mounting"

  validation {
    condition = length(var.fs_label) <= 16
    error_message = "Max 16 characters for FS label for ext4 filesystem"
  }
}
resource "digitalocean_volume" "volume" {
  name                     = var.name
  region                   = var.region
  size                     = var.size
  initial_filesystem_type  = "ext4"
  initial_filesystem_label = var.fs_label
}

output "volume_id" {
  value = digitalocean_volume.volume.id
}
