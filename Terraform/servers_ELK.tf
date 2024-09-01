# Ресурсы для сервера elastic-server
resource "yandex_compute_instance" "elastic" {
  name         = "elastic-server"
  hostname     = "elastic-server.ru-central1.internal"
  platform_id  = "standard-v2"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8j0uq7qcvtb65fbffl"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.elasticsearch_subnet.id
    nat       = false
    security_group_ids = [yandex_vpc_security_group.elastic-sg.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
  }
}


# Ресурсы для сервера kibana-server
resource "yandex_compute_instance" "kibana" {
  name         = "kibana-server"
  hostname     = "kibana-server.ru-central1.internal"
  platform_id  = "standard-v2"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8j0uq7qcvtb65fbffl"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_services_subnet.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.kibana-sg.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
  }
}