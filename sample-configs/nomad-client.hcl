name = "nomad-client-1"
data_dir = "/opt/nomad"
region = "us"
datacenter = "us-ord"


advertise {
    http = "10.0.0.17"
    rpc  = "10.0.0.17"
    serf = "10.0.0.17"
}

bind_addr = "0.0.0.0"


server {
    enabled = false
}

client {
    enabled = true
    host_volume "shared" {
        path      = "/mnt/shared"
        read_only = false
    }
    
    servers = [
                "10.0.0.5:4647",
                "10.0.0.6:4647",
                "10.0.0.7:4647",
            ]
    options = {
        "driver.raw_exec.enable" = "1"
        "docker.privileged.enabled" = "true"
    }
    alloc_dir = "/opt/nomad/alloc"
    state_dir = "/opt/nomad/client"

    # Docker plugin configuration
    meta {
        "docker" = "true"
    }
}

plugin "docker" {
    config {
        volumes {
            enabled = true
        }
    }
}



consul {
    address = "127.0.0.1:8500"
    client_auto_join = true
    server_auto_join = true
}
