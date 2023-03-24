variable "cluster_name" {
  type = string
}

variable "k8s_version_prefix" {
  type        = string
  description = "Major.minor version to pin the cluster to. (example - '1.25.')"
  default     = "1.25."
}

variable "region" {
  type = string
}

variable "size" {
  default = "s-1vcpu-2gb"
  type    = string
}
variable "vpc_uuid" {
  type        = string
  description = "Private VPC network where cluster should be"
}

variable "env" {
  type        = string
  description = "K8S cluster environment"
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "Tags applied on cluster"
}
