### Данные для авторизации:

### Схема сети:
![Схема сети Draw.io](https://github.com/user-attachments/assets/3e37dc9c-5568-4958-b65a-0a1e5e8e7884)

### Созданные VM:
Скриншот

### Сайт:
Мы создали две виртуальные машины (ВМ) в разных зонах и установили на них сервер NGINX:
- [Конфигурация ресурсов NGINX серверов (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/servers_nginx.tf)
- [Конфигурация установки NGINX (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/nginx_conf.yaml)

Настроен балансировщик приложений (App Load Balancer):
- [Конфигурация App Load Balancer (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/L7_balancer_conf.tf)

Тестирование балансировщика с помощью `curl`:

Скриншоты

### Мониторинг:
Мы развернули виртуальную машину с сервером Zabbix и установили Zabbix Agent на остальные серверы:
- [Конфигурация ресурсов Zabbix сервера (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/server_zabbix.tf)
- [Конфигурация Zabbix сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/zabbix-server)
- [Конфигурация Zabbix Agent (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/zabbix-agent)

Установка Zabbix Agent на Bastion сервер осуществляется локально, так как разрешен только трафик на порт 22:
- [Конфигурация Zabbix Agent на Bastion сервере (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/bastion-zabbix-agent)

Настроены дешборды для отображения метрик:
Скриншоты

### Логи:
Созданы две виртуальные машины с Elastic и Kibana:
- [Конфигурация ресурсов Elastic и Kibana (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/servers_ELK.tf)
- [Конфигурация Elastic сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/elastic)
- [Конфигурация Kibana сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/kibana)

На серверах NGINX установлен и настроен Filebeat:
- [Конфигурация NGINX сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/nginx)

Дашборд для отображения логов:
Скриншот

### Сеть:
Развернут один VPC. Серверы NGINX и Elasticsearch размещены в приватных подсетях, а серверы Zabbix, Kibana и App Load Balancer — в публичной подсети:
- [Конфигурация сети (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/network_conf.tf)

Настроены Security Groups для серверов, разрешающие входящий трафик только на необходимые порты:
- [Конфигурация Security Groups (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/security_group.tf)

Создан и настроен Bastion сервер. В Ansible применяется ProxyCommand для маршрутизации трафика через этот сервер:
- [Конфигурация Bastion сервера (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/server_bastion.tf)
- [Конфигурация ProxyCommand (Ansible)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/ansible.cfg)
- [Конфигурация inventory (Ansible)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/inventory.ini)

Исходящий доступ в интернет для внутренних ВМ осуществляется через NAT:
- [Конфигурация NAT (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/nat_conf.tf)

### Резервное копирование:
- [Конфигурация расписания резервного копирования (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/snapshots.tf)

Скриншот


