output "ip_address_server_bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

# output "ip_address_server_zabbix" {
#   value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
# }

# output "ip_address_server_kibana" {
#   value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
# }

# output "ip_address_server_L7_balancer" {
#   value = yandex_alb_load_balancer.l7-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
# }

