node_name = "nomad-server-0"
datacenter = "us-ord"
data_dir = "/opt/consul"
log_file = "/var/log/consul/consul.log"

log_level = "INFO"

bootstrap_expect = 3
server = true
ui_config {
    enabled = true
}

bind_addr="10.0.0.5"
advertise_addr="10.0.0.5"
client_addr = "0.0.0.0"

retry_join = [
"10.0.0.5","10.0.0.6","10.0.0.7"]

ports {
    grpc = 8502
}

connect {
    enabled = true
}
