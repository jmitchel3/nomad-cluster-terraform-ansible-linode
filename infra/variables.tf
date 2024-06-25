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

