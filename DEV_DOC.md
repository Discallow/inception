This document explains how a developer can set up, build, and manage the Inception project stack.

---

## Environment Setup

### Prerequisites

- Docker
- Docker Compose
- Bash shell / terminal

Fill in the empty fields for passwords:
```bash
MYSQL_PASSWORD=supersecret
MYSQL_ROOT_PASSWORD=rootsecret
WP_ADMIN_PASSWORD=wpsecret
WP_USER_PASSWORD=usersecret
```

### Repository Structure Overview

├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   ├── requirements/
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   │       └── nginx.conf
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   ├── conf/
│   │   │   │   └── 50-server.cnf
│   │   │   └── tools/
│   │   │       └── entrypoint.sh
│   │   └── wordpress/
│   │       ├── Dockerfile
│   │       ├── conf/
│   │       │   └── www.conf
│   │       └── tools/
│   │           └── wordpress.sh
├── .env
├── Makefile
├── USER_DOC.md
└── DEV_DOC.md



## Building and Launching the Project
Build and start all containers:

```bash
make
```

This process will:

- Build images for NGINX, WordPress + PHP-FPM, and MariaDB
- Create volumes and networks
- Initialize WordPress and the database
- Start all services in detached mode

## Managing Containers and Volumes

- Stopping containers:

```bash
make down
```

- Cleaning volumes:

```bash
docker volume rm $(docker volume ls -q)
```

- Remove host bind mount data (if used):

```bash
sudo rm -rf /home/$USER/data/wordpress/*
sudo rm -rf /home/$USER/data/mysql/*
```
- Logs and troubleshooting:
View logs for all containers:

```bash
docker compose logs --tail=100 -f
```

View logs for a single service:

```bash
docker compose logs -f wordpress/mariadb/nginx
```

## Data Persistence

- MariaDB data: store MariaDB database files on host (/home/$USER/data/mysql)
- WordPress files: store WordPress files on host (/home/$USER/data/wordpress)

**Even if containers are removed, data persists in Docker volumes. Bind mounts store data directly on the host path.**
