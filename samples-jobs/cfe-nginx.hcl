job "cfe-nginx" {
  # Specifies the datacenter where this job should be run
  # This can be omitted and it will default to ["*"]
  datacenters = ["us-ord"]

  # A group defines a series of tasks that should be co-located
  # on the same client (host). All tasks within a group will be
  # placed on the same host.
  group "servers" {

    # Specifies the number of instances of this group that should be running.
    # Use this to scale or parallelize your job.
    # This can be omitted and it will default to 1.
    count = 1

    network {
      port "www" {
        to = 80
      }
    }

    service {
      name     = "cfe-nginx"
      port     = "www"
        check {
            type     = "http"
            path     = "/"
            interval = "2s"
            timeout  = "2s"
        }
    }

    # Tasks are individual units of work that are run by Nomad.
    task "web" {
      # This particular task starts a simple web server within a Docker container
      driver = "docker"

      config {
        image   = "codingforentrepreneurs/cfe-nginx"
        ports   = ["www"]
      }

      # Specify the maximum resources required to run the task
      resources {
        cpu    = 50
        memory = 64
      }
    }
  }
}