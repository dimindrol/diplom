#Данные для авторизации через yandex_cloud
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token                    = var.YC_TOKEN
  cloud_id                 = var.YC_CLOUD_ID
  folder_id                = var.YC_FOLDER_ID
  zone                     = var.zone
}

