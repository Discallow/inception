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

2. Building and Launching the Project
Build and start all containers:

make
# or directly
docker compose up --build -d
This process will:

Build images for NGINX, WordPress + PHP-FPM, and MariaDB

Create volumes and networks

Initialize WordPress and the database

Start all services in detached mode

3. Managing Containers and Volumes
Stopping containers:
bash
Copiar código
make down
# or
docker compose down
Cleaning volumes:
bash
Copiar código
docker volume rm $(docker volume ls -q)
Remove host bind mount data (if used):

bash
Copiar código
sudo rm -rf /home/$USER/data/wordpress/*
sudo rm -rf /home/$USER/data/mysql/*
Logs and troubleshooting:
View logs for all containers:

bash
Copiar código
docker compose logs --tail=100 -f
View logs for a single service:

bash
Copiar código
docker compose logs -f wordpress
4. Data Persistence
MariaDB data: stored in Docker volume mariadb_data (or bind mount if configured)

WordPress files: stored in Docker volume wordpress_data (or bind mount if configured)

Even if containers are removed, data persists in Docker volumes. Bind mounts store data directly on the host path.

5. Advanced Developer Tasks
Rebuild images after Dockerfile changes:

bash
Copiar código
docker compose up --build --force-recreate -d
Access a container shell for debugging:

bash
Copiar código
docker exec -it wordpress bash
docker exec -it mariadb bash
Run WP-CLI commands inside the WordPress container:

bash
Copiar código
docker exec -it wordpress wp plugin list --allow-root
