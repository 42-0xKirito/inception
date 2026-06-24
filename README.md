*This project has been created as part of the 42 curriculum by engiacom*

## *Description*

**Inception** is a system administration project focused on containerization using **Docker** and **Docker Compose**. The objective is to deploy a small infrastructure composed of three isolated services:

* nginx with TLSv1.2/TLSv1.3 support
* mariadb
* wordpress with php-fpm

Each service is built from its own **Dockerfile** and configured independently.

**Docker** allows applications and their dependencies to run inside lightweight and isolated environments called **containers**. This guarantees that the same infrastructure can be deployed consistently regardless of the host operating system.

Containers share the host kernel while remaining isolated from one another. They communicate through a dedicated Docker network and can exchange data through mounted volumes.

---

## *Instructions*

The project follows the requirements defined by the 42 subject:

* The project must be developed on a virtual machine.
* Services must be orchestrated using **docker-compose**.
* One service per container.
* Each service must have its own **Dockerfile**.
* Containers must be built from a Debian-based image.
* The infrastructure must be launched through a **Makefile**, which calls **docker-compose.yml**.

The stack contains the following services:

* **nginx** acting as a reverse proxy
* **wordpress** running through php-fpm
* **mariadb** providing database services

A Docker network allows communication between containers while keeping them isolated from the host system.

The project also uses persistent volumes to preserve data between container restarts.

---

## *Project Structure*

The infrastructure is organized as follows:

```text
.
├── Makefile
├── docker-compose.yml
└── srcs
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   └── tools
        │       └── init.sh
        ├── nginx
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── nginx.conf
        │   └── tools
        │       └── init.sh
        └── wordpress
            ├── Dockerfile
            ├── conf
            │   └── www.conf
            └── tools
                └── init.sh
```

### Directory Overview

* **Makefile**: main entry point used to manage the infrastructure.
* **docker-compose.yml**: defines services, volumes, networks, and container configuration.
* **srcs/requirements/**: contains all service definitions.
* **Dockerfile**: builds a custom image for each service.
* **conf/**: service-specific configuration files.
* **tools/init.sh**: initialization scripts executed when containers start.

---

## *Architecture*

The infrastructure is composed of three containers:

```text
                 Internet
                     │
                     ▼
               ┌─────────┐
               │  nginx  │
               └────┬────┘
                    │
                    ▼
             ┌────────────┐
             │ wordpress  │
             │  php-fpm   │
             └────┬───────┘
                  │
                  ▼
             ┌──────────┐
             │ mariadb  │
             └──────────┘
```

* **nginx** receives HTTPS requests and forwards them to WordPress.
* **wordpress** handles PHP execution through php-fpm.
* **mariadb** stores WordPress data and user information.

---

## *Resources*

Official documentation:

* https://docs.docker.com
* https://docs.docker.com/compose/
* https://nginx.org/en/docs/
* https://mariadb.org/documentation/
* https://wordpress.org/support/

These resources provide detailed explanations about containerization, networking, volumes, reverse proxies, and service configuration.
