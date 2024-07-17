job "load-balancing" {
    datacenters = ["*"]

    group "servers" {
        count = 1

        restart {
	        attempts = 3
	        delay    = "30s"
        }

        network {
	        port "http" {
	            static = 8080
	        }
        }

        service {
            name = "load-balancing"
            port = "http"
        }

        task "nginx" {
            driver = "docker"

            config {
                image = "nginx"

                ports = ["http"]

                volumes = [
                    "local:/etc/nginx/conf.d",
                ]
        }

        template {
            data = <<EOF
upstream backend {
    {{ range service "cfe-nginx" }}
    server {{ .Address }}:{{ .Port }};
    {{ end }}
    {{ range service "iac-python" }}
    server {{ .Address }}:{{ .Port }};
    {{ else }}server 127.0.0.1:65535; # force a 502
    {{ end }}
}

server {
    listen 8080;

    location / {
        proxy_pass http://backend;
    }
}
EOF

            destination   = "local/load-balancer.conf"
            change_mode   = "signal"
            change_signal = "SIGHUP"
            }
        }
    }
}