output "ip_address_server_bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "ip_address_server_zabbix" {
  value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
}

output "ip_address_server_kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}