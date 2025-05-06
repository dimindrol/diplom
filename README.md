## «Системный администратор» Пергунов Д.В
### Данные для авторизации:
Zabbix http://89.169.148.216:8080/ Логин: Admin пароль: zabbix  
Kibana http://89.169.152.105:5601/ Пароль не требуется  
APP балансировщик: http://84.201.145.110/  
Бастион сервер: 89.169.149.179  

### Схема сети:
![Схема сети Draw.io](https://github.com/user-attachments/assets/3e37dc9c-5568-4958-b65a-0a1e5e8e7884)

### Созданные VM:
![image](https://github.com/user-attachments/assets/effdc42a-f35b-4fa3-91a5-7baa63246a23)


### Сайт:
Мы создали две виртуальные машины (ВМ) в разных зонах и установили на них сервер NGINX:
- [Конфигурация ресурсов NGINX серверов (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/servers_nginx.tf)
- [Конфигурация установки NGINX (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/nginx_conf.yaml)

Настроен балансировщик приложений (App Load Balancer):
- [Конфигурация App Load Balancer (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/L7_balancer_conf.tf)

Тестирование балансировщика с помощью `curl`:
![image](https://github.com/user-attachments/assets/b60fa8e7-5e9b-41e0-884c-a50347aceb17)

![image](https://github.com/user-attachments/assets/f61e1083-5a49-49ad-9d48-7bb243114fc2)

Скриншот страницы:  
![image](https://github.com/user-attachments/assets/332da830-1971-4c0e-972a-a7cc6671f8d6)

Скриншот проверки состояния балансировщика:
![image](https://github.com/user-attachments/assets/19b2d261-fdc7-4063-8d06-b80a3ecf14af)



### Мониторинг:
Мы развернули виртуальную машину с сервером Zabbix и установили Zabbix Agent на остальные серверы:
- [Конфигурация ресурсов Zabbix сервера (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/server_zabbix.tf)
- [Конфигурация Zabbix сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/zabbix-server)
- [Конфигурация Zabbix Agent (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/zabbix-agent)

Установка Zabbix Agent на Bastion сервер осуществляется локально, так как разрешен только трафик на порт 22(Работает в активном режиме):
- [Конфигурация Zabbix Agent на Bastion сервере (Ansible)](https://github.com/dimindrol/diplom_netology/tree/aa041b86e4dfb2c216494eefb9eb671d5f3adcd0/Ansible/playbooks/roles/bastion-zabbix-agent)

Настроены дешборды для отображения метрик:
![image](https://github.com/user-attachments/assets/44f80e25-cec1-4cdf-aa6b-3cf85a33c899)  
![image](https://github.com/user-attachments/assets/83aaaed2-f356-4897-a689-e8b80b3991d4)  
![image](https://github.com/user-attachments/assets/0ba1f97c-58fb-412a-82d9-a7e34a7f5af1)




### Логи:
Созданы две виртуальные машины с Elastic и Kibana:
- [Конфигурация ресурсов Elastic и Kibana (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/servers_ELK.tf)
- [Конфигурация Elastic сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/elastic)
- [Конфигурация Kibana сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/kibana)

На серверах NGINX установлен и настроен Filebeat:
- [Конфигурация NGINX сервера (Ansible)](https://github.com/dimindrol/diplom_netology/tree/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/playbooks/roles/nginx)

Вкладка discover:
![image](https://github.com/user-attachments/assets/3b4bbce2-fd9b-419c-b874-989ca570757c)


### Сеть:
Развернут один VPC. Серверы NGINX и Elasticsearch размещены в приватных подсетях, а серверы Zabbix, Kibana и App Load Balancer — в публичной подсети:
- [Конфигурация сети (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/network_conf.tf)

Настроены Security Groups для серверов, разрешающие входящий трафик только на необходимые порты:
- [Конфигурация Security Groups (Terraform)](https://github.com/dimindrol/diplom_netology/blob/3bf5bb6fc63af43be03726e5a6e61b088107ed93/Terraform/security_group.tf)

Создан и настроен Bastion сервер. В Ansible применяется ProxyCommand для маршрутизации трафика через этот сервер:
- [Конфигурация Bastion сервера (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/server_bastion.tf)
- [Конфигурация ProxyCommand (Ansible)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/ansible.cfg)
- [Конфигурация inventory (Ansible)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Ansible/inventory.ini)

Исходящий доступ в интернет для внутренних ВМ осуществляется через NAT:
- [Конфигурация NAT (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/nat_conf.tf)

### Резервное копирование:
- [Конфигурация расписания резервного копирования (Terraform)](https://github.com/dimindrol/diplom_netology/blob/37595c95621cc41a8ca2fb636910ad734a4ab516/Terraform/snapshots.tf)  
Настроено расписание для автоматического создания vm-snapshots
![image](https://github.com/user-attachments/assets/84c29b0f-5dcc-4111-ac0f-adc1fb1f26da)
Снимки дисков по расписанию создаются:
![image](https://github.com/user-attachments/assets/3e24d41f-8b9a-4a71-b1dd-7d815cef873b)


