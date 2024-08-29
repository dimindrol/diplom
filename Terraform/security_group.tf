resource "yandex_vpc_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security group for bastion server"
  network_id  = yandex_vpc_network.my_vpc.id

  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.16/28"]
    port           = 10050
  }

  egress {
    description    = "Allow SSH to Servers"
    protocol       = "TCP"
    v4_cidr_blocks = [
      "10.0.1.0/28", 
      "10.0.1.16/28", 
      "10.0.2.0/28", 
      "10.0.2.16/28", 
      "10.0.2.32/28"
    ]
    port           = 22
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "web-nginx-sg" {
  name        = "web-nginx-sg"
  description = "Security group for web-nginx-servers"
  network_id  = yandex_vpc_network.my_vpc.id

  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.0/28"]
    port           = 22
  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.16/28"]
    port           = 10050
  }

  ingress {
    description    = "Allow HTTP"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.0/28"]
    port           = 80
  }

  ingress {
    description    = "Allow HTTPS"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.0/28"]
    port           = 443
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "zabbix-sg" {
  name        = "zabbix-sg"
  description = "Security group for zabbix-server"
  network_id  = yandex_vpc_network.my_vpc.id

  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.0/28"]
    port           = 22
  }

  ingress {
    description    = "Allow web-zabbix"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "yandex_vpc_security_group" "elastic-sg" {
  name        = "elastic-sg"
  description = "Security group for elastic"
  network_id  = yandex_vpc_network.my_vpc.id
  
  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.0/28"]
    port           = 22
  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.16/28"]
    port           = 10050
  }

  ingress {
    description    = "Allow Elasticsearch"
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["10.0.1.16/28"]
  }

  ingress {
    description    = "Allow web_subnet_a"
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["10.0.2.0/28"]
  }

  ingress {
    description    = "Allow web_subnet_b"
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["10.0.2.16/28"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "yandex_vpc_security_group" "kibana-sg" {
  name        = "kibana-sg"
  description = "Security group for kibana"
  network_id  = yandex_vpc_network.my_vpc.id
  
  ingress {
    description    = "Allow SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.0/28"]
    port           = 22
  }

  ingress {
    description    = "Allow Zabbix-server"
    protocol       = "TCP"
    v4_cidr_blocks = ["10.0.1.16/28"]
    port           = 10050
  }

  ingress {
    description    = "Allow kibana"
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}