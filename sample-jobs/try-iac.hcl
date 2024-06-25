job "try-iac" {
    datacenters = ["*"]

    meta {
        foo = "bar"
    }

    update {
        max_parallel      = 1
        min_healthy_time  = "10s"
        healthy_deadline  = "3m"
        auto_revert       = true
        canary            = 1
        auto_promote      = true
        # promote_deadline  = "5m"
        stagger           = "30s"
    }

    group "servers" {
        count = 1

        network {
            port "www" {
                to = 8082
            }
        }

        service {
            provider = "nomad"
            port     = "www"
        }

        task "web" {
            driver = "docker"
            
            env {
                PORT = "8082"
            }

            config {
                image   = "codingforentrepreneurs/iac-python"
                ports   = ["www"]
            }

            resources {
                cpu    = 500 # 500 MHz
                memory = 256 # 256MB
            }
        }
    }
}