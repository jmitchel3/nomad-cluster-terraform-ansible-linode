variable "linode_api_token" {
    type                = string
    description         = "Linode's API token"
    sensitive           = true
}

# https://api.linode.com/v4/regions
variable "linode_region" {
    type                = string
    description         = "Our Linode Region"
    default = "us-ord" # Chicago
} 


variable "linode_instance_image" {
    type                = string
    description         = "Our Linode Image"
    default = "linode/ubuntu22.04"
} 

variable "linode_instance_type" {
    type                = string
    description         = "Our Linode Instance Type"
    default             = "g6-standard-2"
} 

variable "server_count" {
    type                = number
    default             = 3
} 

variable "client_count" {
    type                = number
    default             = 3
} 


variable "ansible_config_dir" {
    type                = string
    default             = "config"
}