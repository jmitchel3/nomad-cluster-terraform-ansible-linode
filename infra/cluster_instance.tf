data "linode_profile" "me" {}

# nomad servers -> tell the clients what containers to run
resource "linode_instance" "nomad_servers" {
    count           = var.server_count # 3, 5, 7
    label           = "nomad-server-${count.index}" # -0, -1, -2
    image           = var.linode_instance_image
    region          = var.linode_region
    type            = var.linode_instance_type

    # ssh keys
    authorized_users = [data.linode_profile.me.username]
    authorized_keys = [trimspace(file("~/.ssh/id_rsa.pub"))]

    interface {
        purpose = "public" # public IP
    }

    interface {
        purpose   = "vpc"
        subnet_id = linode_vpc_subnet.ha-nomad-vpc-subnet.id
        ipv4 {
            vpc = "10.0.0.${count.index + 5}" # vpc-based private ip 5 6 7
        }
    }
}


# nomad clients, if available -> run containers (jobs)

resource "linode_instance" "nomad_clients" {
    count           = var.client_count # 3, 5, 7
    label           = "nomad-client-${count.index}" # -0, -1, -2
    image           = var.linode_instance_image
    region          = var.linode_region
    type            = var.linode_instance_type

    # ssh keys
    authorized_users = [data.linode_profile.me.username]
    authorized_keys = [trimspace(file("~/.ssh/id_rsa.pub"))]

    interface {
        purpose = "public" # public IP
    }

    interface {
        purpose   = "vpc"
        subnet_id = linode_vpc_subnet.ha-nomad-vpc-subnet.id
        ipv4 {
            vpc = "10.0.0.${count.index + var.server_count + 10}" # vpc-based private ip 5 6 7
        }
    }
}