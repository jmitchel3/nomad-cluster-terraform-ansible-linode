node_name = "nomad-client-0"
datacenter = "us-ord"
data_dir = "/opt/consul"
log_file = "/var/log/consul/consul.log"

log_level = "INFO"

server = false
ui_config {
    enabled = false
}

bind_addr="10.0.0.16"
advertise_addr="10.0.0.16"
client_addr = "0.0.0.0"

retry_join = [
"10.0.0.5","10.0.0.6","10.0.0.7"]

ports {
    grpc = 8502
}

connect {
    enabled = true
}
