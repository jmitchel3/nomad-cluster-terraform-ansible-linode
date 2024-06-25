data "linode_profile" "me" {}

resource "linode_instance" "nomad_servers" {
    count           = var.server_count 
    label           = "nomad-server-${count.index}"
    image           = var.linode_instance_image
    region          = var.linode_region
    type            = var.linode_instance_type
    authorized_users = [data.linode_profile.me.username]
    authorized_keys = [trimspace(file("~/.ssh/id_rsa.pub"))]
    tags            = ["nomad-ha"]

    # eth0
    interface {
        purpose   = "vpc"
        subnet_id = linode_vpc_subnet.ha-nomad-vpc-subnet.id
        primary   = true
        ipv4 {
            vpc = "10.0.0.${count.index + 5}"
            nat_1_1 = "any"
        }
    }
}



resource "linode_instance" "nomad_clients" {
    count           = var.client_count 
    label           = "nomad-client-${count.index}"
    image           = var.linode_instance_image
    region          = var.linode_region
    type            = var.linode_instance_type
    authorized_users = [data.linode_profile.me.username]
    tags            = ["nomad-ha"]

    # eth0
    interface {
        purpose   = "vpc"
        primary   = true
        subnet_id = linode_vpc_subnet.ha-nomad-vpc-subnet.id
        ipv4 {
            vpc = "10.0.0.${count.index + var.client_count + var.server_count + 10}"
            nat_1_1 = "any"
        }
    }
    
}