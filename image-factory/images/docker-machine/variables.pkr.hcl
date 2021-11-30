variable "DO_TOKEN" {
    type = string
    sensitive = true
}

locals {
    base_image           = "ubuntu-20-04-x64"
    build_region         = "fra1"
    base_image_size_slug = "s-1vcpu-1gb"
    ssh_username         = "root"


}
