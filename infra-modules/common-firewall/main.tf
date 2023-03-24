variable "env" {
  type = string
}

resource "digitalocean_tag" "egress-internet-fw" {
  name = "egress-internet-fw-${var.env}"
}

resource "digitalocean_tag" "ssh-fw" {
  name = "ssh-fw-${var.env}"
}

resource "digitalocean_firewall" "egress-internet-fw" {
  name = "egress-internet-${var.env}"
  tags = [digitalocean_tag.egress-internet-fw.id]

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0"]
  }
}

resource "digitalocean_firewall" "ingress-ssh" {
  name = "ingress-ssh-${var.env}"
  tags = [digitalocean_tag.ssh-fw.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }
}

output "fw-tags" {
  value = {
    ssh             = digitalocean_tag.ssh-fw.id
    internet-egress = digitalocean_tag.egress-internet-fw.id
  }
  description = "Tags for droplets, available to be attached"
}
