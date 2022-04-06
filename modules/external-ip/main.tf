data "http" "external_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  external_ip_json = jsondecode(data.http.external_ip.body)
}

output "external_ip" {
  value = local.external_ip_json.ip
}
