# Создание VPC
resource "yandex_vpc_network" "my_vpc" {
  name        = "network-1"
  description = "VPC_network"
}

# Публичная подсеть
resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my_vpc.id
  v4_cidr_blocks = ["10.0.1.0/28"]
}

# Публичная подсеть для Zabbix и Kibana
resource "yandex_vpc_subnet" "public_services_subnet" {
  name           = "public-services-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my_vpc.id
  v4_cidr_blocks = ["10.0.1.16/28"]
}

# Приватная подсеть для web-серверов
resource "yandex_vpc_subnet" "web_subnet_a" {
  name           = "web_subnet_a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my_vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.0.2.0/28"]
}

# Приватная подсеть для web-серверов
resource "yandex_vpc_subnet" "web_subnet_b" {
  name           = "web_subnet_b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.my_vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.0.2.16/28"]
}

# Приватная подсеть для Elasticsearch
resource "yandex_vpc_subnet" "elasticsearch_subnet" {
  name           = "elasticsearch-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my_vpc.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.0.2.32/28"]
}






