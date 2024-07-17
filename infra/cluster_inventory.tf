
# [for i in linode_instance.nomad_servers:{name=i.label, public_ip=i.ip_address, subnet_ip=linode_instance.nomad_servers[0].interface[1].ipv4[0].vpc, region=i.region}]
# linode_instance.nomad_servers[0].interface[1].ipv4[0].vpc

resource "local_file" "ansible_inventory" {
    depends_on = [ linode_instance.nomad_servers, linode_instance.nomad_clients]
    content = templatefile("${path.module}/templates/ansible.inventory.tpl", {
        nodmad_servers = [
            for i in linode_instance.nomad_servers: {
                name=i.label
                public_ip=i.ip_address
                subnet_ip=i.interface[1].ipv4[0].vpc
                region=i.region
            }
        ]
        nomad_clients = [
            for i in linode_instance.nomad_clients: {
                name=i.label
                public_ip=i.ip_address
                subnet_ip=i.interface[1].ipv4[0].vpc
                region=i.region
            }
        ]
    })
    filename = "${local.repo_dir}/${var.ansible_config_dir}/inventory.ini"
}