output "noteboard_client_url" {
  value = "http://${module.noteboard_client_elb.elb_dns_name}"
}

output "noteboard_api_url" {
  value = "http://${module.noteboard_api_elb.elb_dns_name}"
}