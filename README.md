### Данные для авторизации:


### Схема сети:
![Схема сети drawio](https://github.com/user-attachments/assets/3e37dc9c-5568-4958-b65a-0a1e5e8e7884)

### Созданные VM:
Скриншот



  
### Сайт:
Создали две ВМ в разных зонах, установили на них сервер nginx:  
- [Terraforn конфигурация ресурсов NGINX серверов](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/servers_nginx.tf)   
- [Terraforn конфигурация установки NGINX](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/nginx_conf.yaml)  

Настроен APP Балансировщик:  
- [Terraforn конфигурация APP балансировщика](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/L7_balancer_conf.tf)  
Тестирование балансировщика с использованием curl:  

```
Запрос CURL
```

Скриншоты

### Мониторинг:  
Создали ВМ и развернули на ней Zabbix сервер, а на всех прочих серверах zabbix agent:  
- [Terraforn конфигурация ресурсов Zabbix сервера](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/server_zabbix.tf)  
- [Ansible конфигурация Zabbix сервера](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/zabbix-server)  
- [Ansible конфигурация Zabbix agent](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/zabbix-agent)  
На бастион сервер установка осуществляется локально, так как трафик разрешен только на 22 порту  
- [Ansible конфигурация Zabbix agent Bastion сервер](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/bastion-zabbix-agent)  
Настроены дешборды с отображением метрик:  
Скриншоты

### Логи:
Настроены две VM c elastic и kibana:  
- [Terraforn конфигурация ресурсов elastic и kibana](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/servers_ELK.tf)  
- [Ansible конфигурация elastic сервера](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/elastic)  
- [Ansible конфигурация kibana сервера](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/kibana)  
На Nginx серверах установлен и сконфигурирован filebeat:  
- [Ansible конфигурация Nginx сервера](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/nginx)  
Дашборд с отображением логов:  
Скриншот

### Сеть:
Развернули один VPC. Сервера nginx, elasticsearch поместите в приватные подсети. Сервера Zabbix, Kibana, app load balancer определили в публичную подсеть.  
- [Terraforn конфигурация сети](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/network_conf.tf)  
Настроили Security Groups соответствующих серверов на входящий трафик только к нужным портам:  
- [Terraforn конфигурация Security Groups](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/security_group.tf)  
Создан и настроен сервер bastion сервер, в Ansible применяется ProxyCommand, все данные ходят только через него.  
- [Terraforn конфигурация ресурсов bastion сервер](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/server_bastion.tf)  
- [Ansible конфигурация ProxyCommand](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/ansible.cfg)  
- [Ansible конфигурация inventory](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/inventory.ini)  
Исходящий доступ в интернет для VM внутреннего контура осуществляется через NAT:  
- [Terraforn конфигурвция NAT](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/nat_conf.tf)  

### Резервное копирование:  
[Terraforn конфигурвция расписания резервного копирования](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/snapshots.tf)  
скриншот

