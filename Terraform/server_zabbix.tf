# zabbix сервер
resource "yandex_compute_instance" "zabbix" {
  name         = "zabbix-server"
  hostname     = "zabbix-server.ru-central1.internal"
  platform_id  = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
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
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
  }
}