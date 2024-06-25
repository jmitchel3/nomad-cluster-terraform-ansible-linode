job "cfe-nginx" {
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
                to = 80
            }
        }

        service {
            name = "cfe-nginx"
            port = "www"

            check {
                type     = "http"
                path     = "/"
                interval = "2s"
                timeout  = "2s"
            }
        }

        task "web" {
            driver = "docker"

            config {
                image   = "codingforentrepreneurs/cfe-nginx"
                ports   = ["www"]
            }

            resources {
                cpu    = 500 # 500 MHz
                memory = 256 # 256MB
            }
        }
    }
}