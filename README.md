README.md (Ready to Use)

This project has been created as part of the 42 curriculum by <dioalexa>.

Inception
1. Description

Inception is a systems-administration and container-orchestration project whose objective is to build a fully containerized multi-service infrastructure using Docker.
The project requires assembling a functional WordPress website by provisioning and orchestrating multiple Docker containers interconnected through a custom network.
No third-party Docker images are allowed; all images (NGINX, WordPress + PHP-FPM, MariaDB) must be built from scratch using clean Debian/Alpine base images.

The result is a minimal, reproducible, and isolated environment that runs:

A MariaDB database service

A WordPress instance running on PHP-FPM

An NGINX reverse proxy configured for HTTPS (TLS)

Persistent storage for database and website data

A bridge network enabling inter-container communication

The goal is to understand containerization concepts, image-building strategies, the use of volumes, networking, and secure configuration through environment variables and secrets.

2. Instructions
Requirements

Docker

Docker Compose

A valid TLS certificate pair (.crt and .key)

Environment Variables

All environment variables must be stored in a .env file (not committed to Git).
An example file .env is provided.

To run the project:

make


To stop the stack:

make down


To clean persistent volumes:

docker volume rm $(docker volume ls -q)
sudo rm -rf /home/user/data/wordpress/* /home/user/data/mysql/*

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

5. Resources
Documentation

Docker documentation

Docker Networking documentation

MariaDB Knowledge Base

NGINX official documentation

WordPress Codex and WP-CLI reference

Tutorials and Articles

Docker best practices for production

Guide to PHP-FPM and FastCGI

TLS/SSL introduction

Use of AI

AI (ChatGPT) was used exclusively for:

Reviewing configuration files for correctness (NGINX, MariaDB, Dockerfiles)

Generating explanatory comments for configuration and scripts

Clarifying Docker networking concepts and WordPress internal mechanisms

Drafting documentation structure and improving technical explanations

All implementation, debugging, and architectural decisions were made manually.

#####
docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi -f $(docker images -aq);
docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q);
sudo rm -rf /home/discallow/data/wordpress/* /home/discallow/data/mysql/*
