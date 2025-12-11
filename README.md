_This project has been created as part of the 42 curriculum by <dioalexa>._

# Inception
## Table of Contents
- [Description](#Description)
- [Instructions](#Instructions)
- [Resources](#resources)
- [Installation](#installation)
- [Usage](#usage)
- [Built-in Commands](#built-in-commands)
- [External Commands](#external-commands)
- [Error Handling](#error-handling)
- [Resources](#resources)
- [Author](#author)
## 1. Description

Inception is a systems-administration and container-orchestration project whose objective is to build a fully containerized multi-service infrastructure using Docker.
The project requires assembling a functional WordPress website by provisioning and orchestrating multiple Docker containers interconnected through a custom network.
No third-party Docker images are allowed; all images (NGINX, WordPress + PHP-FPM, MariaDB) must be built from scratch using clean Debian/Alpine base images.

The result is a minimal, reproducible, and isolated environment that runs:

- A MariaDB database service
- A WordPress instance running on PHP-FPM
- An NGINX reverse proxy configured for HTTPS (TLS)
- Persistent storage for database and website data
- A bridge network enabling inter-container communication

The goal is to understand containerization concepts, image-building strategies, the use of volumes, networking, and secure configuration through environment variables and secrets.

## 2. Instructions

**Requirements:**

- Docker
- Docker Compose
- A valid TLS certificate pair (.crt and .key)
- Environment Variables :
    - All environment variables must be stored in a .env file (not committed to Git). An example file .env is provided.

To run the project:
```bash
$make
```

To stop the stack:

```bash
$make down
```

To clean persistent volumes:

```bash
$docker volume rm $(docker volume ls -q)
$sudo rm -rf /home/user/data/wordpress/* /home/user/data/mysql/*
```

## 3. Resources

### Documentation used:

### - YouTube videos:
  - [Network Chuck - Docker Tutorials](https://www.youtube.com/watch?v=dH3DdLy574M&list=PLIhvC56v63IJlnU4k60d0oFIrsbXEivQo)
  - [FreeCodeCamp - Docker Tutorial for Beginners - A Full DevOps Course on How to Run Applications in Containers](https://www.youtube.com/watch?v=fqMOX6JJhGo)
  - [DevOps Directive - Complete Docker Course - From BEGINNER to PRO! (Learn Containers)](https://www.youtube.com/watch?v=RqTEHSBrYFw)
  - [Christian Lempa - Docker Networking Tutorial, ALL Network Types explained!](https://www.youtube.com/watch?v=5grbXvV_DSk)
  - [Programming with Mosh - Docker Compose Tutorial](https://www.youtube.com/watch?v=HG6yIjZapSA)
  - [develop with Ahmad Mohey - MariaDB Tutorial For Beginners in One Hour](https://www.youtube.com/watch?v=_AMj02sANpI)
  - [Sematext - SSL/TLS Explained in 7 Minutes](https://www.youtube.com/watch?v=67Kfsmy_frM)
  - [Computerphile - TLS Handshake Explained](https://www.youtube.com/watch?v=86cQJ0MMses)

### - MariaDB Knowledge Base
 - [Import and Export Databases in MySQL using Command Line](https://www.interserver.net/tips/kb/import-export-databases-mysql-command-line/)
 - [Inception 42 project - Configuring mariaDB and installing wp-cli](https://medium.com/@ssterdev/inception-42-project-part-ii-19a06962cf3b)
 - [Create and give permissions to a user](https://www.daniloaz.com/en/how-to-create-a-user-in-mysql-mariadb-and-grant-permissions-on-a-specific-database/) 
 - [How to give all privileges for a user on a database](https://chartio.com/resources/tutorials/how-to-grant-all-privileges-on-a-database-in-mysql/)

### - NGINX official documentation
 - [NGINX documentation](https://nginx.org/en/docs/index.html)
 - [location explanations](https://www.digitalocean.com/community/tutorials/nginx-location-directive)
 - [What is a proxy server](https://www.varonis.com/fr/blog/serveur-proxy)
 - [All nginx definitions](http://nginx.org/en/docs/http/ngx_http_core_module.html)
 - [Nginx Command line](https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/)

### WordPress and WP-CLI reference
- [What is the wordpress CLI](https://www.dreamhost.com/wordpress/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI.)  
- [Know more about wp-config.php](https://wpformation.com/wp-config-php-et-functions-php-fichiers-wordpress/)  
- [php-fpm - www.conf](https://myjeeva.com/php-fpm-configuration-101.html)  

### Use of AI

AI (ChatGPT) was used for:
- Reviewing configuration files for correctness (NGINX, MariaDB, Dockerfiles);
- Generating explanatory comments for configuration and scripts;
- Clarifying Docker networking concepts and WordPress internal mechanisms;
- Drafting documentation structure and improving technical explanations;
- All implementation, debugging, and architectural decisions were made manually.

4. Project Description
Use of Docker

The project uses Docker to build three independent services:

MariaDB container:
Custom Debian-based image running MariaDB, with an initialization script that creates users, database schema, and permissions based on environment variables.

WordPress + PHP-FPM container:
Custom image that installs PHP, WordPress CLI, WordPress core, and sets up an administrator and a subscriber user using environment variables.

NGINX container:
Custom image providing a reverse proxy with HTTPS enabled using a self-signed TLS certificate.
NGINX forwards PHP requests to the WordPress PHP-FPM container (FastCGI).

A Docker bridge network ensures communication between containers using DNS names.
Bind-mounted volumes ensure persistence of database and WordPress data outside containers.

Sources Included

srcs/docker-compose.yml

Custom Dockerfiles for each service

Configuration files (nginx.conf, 50-server.cnf, www.conf)

TLS certificate creation script

MariaDB initialization script

WordPress initialization script

5. Technical Comparisons (Required by Subject)
4.1 Virtual Machines vs Docker
Aspect	Virtual Machine	Docker Container
Guest OS	Full OS per VM	Shares host kernel
Resource usage	Heavy	Lightweight
Startup time	Slow	Very fast
Isolation level	Strong (hardware-level)	Process-level
Purpose	Full system simulation	Application packaging

Summary: Docker is significantly more efficient for microservices and application deployment, while VMs provide stronger isolation but require more resources.

4.2 Secrets vs Environment Variables
Aspect	Environment Variables	Docker Secrets
Storage	In .env files or Compose file	Encrypted and managed by Docker
Security	Visible via docker inspect	Hidden at runtime
Best use	Non-sensitive config	Passwords, certificates

Summary: Environment variables define configuration. Secrets must be used for confidential credentials in production.

4.3 Docker Network vs Host Network
Aspect	Docker Bridge Network	Host Network
Isolation	Containers isolated from host	Container shares host network stack
Security	Higher	Lower
Port binding	Required	Not needed
Use case	Multi-service stacks	High-performance network apps

Summary: Bridge networks are ideal for orchestrated, multi-container designs where explicit routing and isolation are required.

4.4 Docker Volumes vs Bind Mounts
Aspect	Volume	Bind Mount
Managed by Docker	Yes	No
Location	/var/lib/docker/volumes/...	Any host path
Backups	Easy	Controlled manually
Use case	Generic persistent data	Projects requiring exact host path

Summary: Volumes provide portability and Docker-level management, while bind mounts allow precise storage locations such as /home/user/data.



#####
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -aq);
docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q);
sudo rm -rf /home/discallow/data/wordpress/* /home/discallow/data/mysql/*
