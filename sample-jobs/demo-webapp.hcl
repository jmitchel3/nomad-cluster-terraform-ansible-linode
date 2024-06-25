job "demo-webapp" {
  datacenters = ["*"]

  group "demo" {
    count = 3

    restart {
      attempts = 3
      delay    = "30s"
    }

    network {
      port "http" {
        to = -1
      }
    }

    service {
      name = "demo-webapp"
      port = "http"

      check {
        type     = "http"
        path     = "/"
        interval = "2s"
        timeout  = "2s"
      }
    }

    task "server" {
      env {
        PORT    = "${NOMAD_PORT_http}"
        NODE_IP = "${NOMAD_IP_http}"
      }

      driver = "docker"

      config {
        image = "hashicorp/demo-webapp-lb-guide"
        ports = ["http"]
      }
    }
  }
}