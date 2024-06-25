resource "linode_vpc" "ha-nomad-vpc" {
    label = "ha-nomad-vpc"
    region = var.linode_region
    description = "My Nomad VPC."
}

resource "linode_vpc_subnet" "ha-nomad-vpc-subnet" {
    vpc_id = linode_vpc.ha-nomad-vpc.id
    label = "ha-nomad-vpc-subnet"
    ipv4 = "10.0.0.0/24"
}
