variable "linode_api_token" {
  type              = string
  description       = "Linode's API token"
  sensitive         = true
}

variable "linode_region" {
    type            = string
    description     = "Linode region to deploy resources"
    default         = "us-ord" # Chicago
} 

variable "server_count" {
    type            = number
    description     = "Number of Linode instances to create to run Nomad servers"
    default         = 3
}

variable "client_count" {
    type            = number
    description     = "Number of Linode instances to create to run Nomad clients"
    default         = 3
}

variable "linode_instance_image" {
    type            = string
    description     = "Linode Image to deploy"
    default         = "linode/ubuntu22.04"
}

variable "linode_instance_type" {
    type            = string
    description     = "Linode type to deploy"
    default         = "g6-standard-2"
}

variable "ansible_root_directory" {
    type            = string
    description     = "Ansible directory (relative to repo dir)"
    default         = "config"

}