# nomad run ./nomad/traefik.nomad.hcl
job "traefik" {
  datacenters = ["*"]
  type        = "service"

  group "traefik" {
    count = 1

    network {
      mode = "host"

      port "http" {
        # to     = 8080 # container port the app runs on
        static = 80
      }

      port "https" {
        static = 443
      }

      port "traefik" {
        static = 8080
        to     = 8080
      }

      port "db" {
        static = 5432
        to     = 5432
      }
    }


    service {
      name     = "traefik-http"
      provider = "nomad"
      port     = "traefik"
    }

    task "server" {
      driver = "docker"
      config {
        # network_mode = "bridge"
        image = "traefik:v3.0"
        ports = [
          "http",
          "https",
          "traefik",
          "db"
        ]
        volumes = [
          "local/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }

      # https://doc.traefik.io/traefik/getting-started/configuration-overview/#configuration-file
      template {
        data = <<EOH
[entryPoints]
  [entryPoints.http]
    address = ":80"
  [entryPoints.https]
    address = ":443"
  [entryPoints.traefik]
    address = ":8080"
  [entryPoints.db]
    address = ":5432"

[api]
  dashboard = true
  insecure = true
  debug = true

[providers.nomad]
  refreshInterval = "5s"
  [providers.nomad.endpoint]
    address = "http://{{ env "attr.unique.network.ip-address" }}:4646"
    token   = "$NOMAD_TOKEN"

[log]
  level = "DEBUG"
EOH

        destination = "local/traefik.toml"
      }
    }
  }
}
