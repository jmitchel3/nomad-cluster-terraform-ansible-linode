[servers]
%{ for instance in servers ~}
${instance.name} nomad_type="server" ansible_ssh_host=${instance.public_ip} ansible_ssh_user=root subnet_ip=${instance.subnet_ip} linode_region=${instance.region}
%{ endfor ~}

[clients]
%{ for instance in clients ~}
${instance.name} nomad_type="client" ansible_ssh_host=${instance.public_ip} ansible_ssh_user=root subnet_ip=${instance.subnet_ip} linode_region=${instance.region} 
%{ endfor ~}

[consul_nodes:children]
servers






