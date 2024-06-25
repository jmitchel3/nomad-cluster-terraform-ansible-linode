name = "nomad-server-2"
data_dir = "/opt/nomad"
region = "us"
datacenter = "us-ord"


advertise {
    http = "10.0.0.7"
    rpc  = "10.0.0.7"
    serf = "10.0.0.7"
}

bind_addr = "0.0.0.0"

server {
    enabled = true
    bootstrap_expect = 3
    server_join {
        retry_join = [
                        "10.0.0.5:4648",
                        "10.0.0.6:4648",
                        "10.0.0.7:4648",
                    ]
        retry_max      = 4
        retry_interval = "15s"
    }
}

client {
    enabled = false
}

ui {
    enabled = true
}



consul {
    address = "127.0.0.1:8500"
    client_auto_join = true
    server_auto_join = true
}
