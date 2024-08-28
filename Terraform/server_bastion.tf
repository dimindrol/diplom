# bastion сервер
resource "yandex_compute_instance" "bastion" {
  name         = "bastion-server"
  hostname     = "bastion-server.ru-central1.internal"
  platform_id  = "standard-v2"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 0.5
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8j0uq7qcvtb65fbffl"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    security_group_ids = [yandex_vpc_security_group.bastion-sg.id]
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
  }
}
