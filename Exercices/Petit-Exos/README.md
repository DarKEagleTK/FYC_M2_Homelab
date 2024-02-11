*a)	Exercice : Création de la liste des règles pare-feu de base*


*a) exercice : Installation d'Uptime Kuma sous Docker*

Afin de voir si vous avez bien compris le processus d'installation sur Docker, je vous demanderais de me donner le code d'installation ainsi que les commande d'installation comme effectuer avec prometheus.

```bash
mkdir /etc/uptimekuma
nano /etc/uptimekuma/uptimekuma.yml
```

```yml
# Simple docker-compose.yml
# You can change your port or volume location

version: '3.3'

services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: uptime-kuma
    volumes:
      - ./uptime-kuma-data:/app/data
    ports:
      - 3001:3001  # <Host Port>:<Container Port>
    restart: always
```
```bash
docker volume create uptime-kuma-data
docker run -d --restart=always -p 3001:3001 -v uptime-kuma-data:/etc/uptimekuma -v /etc/uptimekuma/uptimekuma.yml:/etc/uptimekuma/uptimekuma.yml --name uptime-kuma louislam/uptime-kuma:1
```