packer {
    required_plugins {
        digitalocean = {
            version = " >= 1.0.0"
            source  = "github.com/hashicorp/digitalocean"
        }
    }
}

source "digitalocean" "docker-machine-base-snapshot" {
    api_token    = "${var.DO_TOKEN}"
    image        = "${local.base_image}"
    region       = "${local.build_region}"
    size         = "${local.base_image_size_slug}"
    ssh_username = "${local.ssh_username}"
}

build {
    sources = ["source.digitalocean.docker-machine-base-snapshot"]

    provisioner "ansible" {
        command       = "/provision_with_ansible.sh"
        use_proxy     = false
        playbook_file = "docker-machine-bootstrap.yaml"
        user          = "root"
    }
}
