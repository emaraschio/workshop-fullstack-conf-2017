variable "region" {
  default = "us-east-1"
}

variable "key_pair_name" {
  default = "noteboard-cluster-east-1"
}

variable "noteboard_client_image" {
  default = "emaraschio/noteboard-client"
}

variable "noteboard_client_version" {
  default = "latest"
}

variable "noteboard_client_port" {
  default = 4000
}

variable "noteboard_api_image" {
  default = "emaraschio/noteboard-api"
}

variable "noteboard_api_version" {
  default = "latest"
}

variable "noteboard_api_port" {
  default = 3000
}