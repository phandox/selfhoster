locals {
  envs    = ["dev", "test", "stage", "prod"]
  regions = ["fra1", "ams3", "lon1"]
}

variable "region" {
  type    = string
  default = ""
  validation {
    condition     = contains(["fra1", "ams3", "lon1"], var.region)
    error_message = formatlist("Only Europe regions are available. Use %s", ["fra1", "ams3", "lon1"])
  }
}
variable "env" {
  type = string
  validation {
    condition     = contains(["dev", "test", "stage", "prod"], var.env)
    error_message = formatlist("Invalid environment. Env must be from %s", ["dev", "test", "stage", "prod"])
  }
}

variable "ip_range" {
  type    = string
  default = ""
  validation {
    condition     = can(cidrhost(var.ip_range, 1))
    error_message = "Only valid IPv4 subnet can be passed to variable. Example - 10.0.0.0/24"
  }
  validation {
    condition     = startswith(var.ip_range, "10.")
    error_message = "Only IP range from 10.0.0.0/8 is accepted"
  }
}

resource "digitalocean_vpc" "vpc" {
  name        = "vpc-${var.env}-${var.region}"
  region      = var.region
  ip_range    = var.ip_range
  description = "VPC network for ${var.env}"
}

output "vpc" {
  value = {
    id = digitalocean_vpc.vpc.id
    ip_range = digitalocean_vpc.vpc.ip_range
  }
  description = "VPC values to pass for FW and Droplet resources"
}