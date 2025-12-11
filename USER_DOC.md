This document explains how an end user or administrator can interact with the Inception project stack.

---

## Services Provided

The Inception project stack runs the following services:

| Service     | Purpose                                                                 |
|------------|-------------------------------------------------------------------------|
| MariaDB    | Database storage for WordPress content and users                        |
| WordPress  | Website application running on PHP-FPM                                   |
| NGINX      | Reverse proxy and HTTPS endpoint for WordPress                           |

---

## Starting and Stopping the Project

### Start the stack:

```bash
make
```

### Stop the stack:
```bash
make down
```

## Accessing the Website and Admin Panel

- Open a web browser and go to the URL defined in .env:

https://<WP_URL>

- Example:

https://dioalexa.42.fr

- Access WordPress administration panel:

https://<WP_URL>/wp-admin

Use the credentials defined in .env for the admin user.
A subscriber user is also created as required by the project.

## Managing Credentials

All sensitive credentials are stored in the .env file:
```bash
MYSQL_PASSWORD
MYSQL_ROOT_PASSWORD
WP_ADMIN_PASSWORD
WP_USER_PASSWORD
```

**.env must never be committed to Git.**

Admin and subscriber credentials are defined here and used by WordPress and MariaDB.

## Checking Services

### To check that all containers are running:

```bash
docker ps
```

Expected output:

```bash
Service	State
mariadb	Up (healthy)
wordpress	Up
nginx	Up
```
