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

variable "env" {
  type        = string
  description = "Environment for volume"
}

variable "fs_label" {
  default     = "example"
  type        = string
  description = "Filesystem label for volume, useful for mounting"

  validation {
    condition     = length(var.fs_label) <= 16
    error_message = "Max 16 characters for FS label for ext4 filesystem"
  }
}

variable "tags" {
  default     = []
  type        = list(string)
  description = "Additional tags to be assigned on volume"
}
