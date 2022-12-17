variable "region" {
  default = "fra1"
  type    = string
}

variable "env" {
  type = string
}

variable "ssh_keys" {
  default     = ["37082527"]
  description = "IDs of ssh keys stored in Digital Ocean to be injected to VM. Get the values via `doctl compute ssh-keys list`"
  type        = list(string)
}

variable "tags" {
  default = []
  type    = list(string)
}

variable "instance_count" {
  default = 1
  type    = number
}

variable "instance_size" {
  type    = string
  default = "s-1vcpu-512mb-10gb"
}

variable "vpc" {
  type = object({
    id       = string
    ip_range = string
  })
  description = "VPC network to where instance live"
}