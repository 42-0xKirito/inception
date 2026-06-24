# DEVELOPER DOCUMENTATION

## Setting Up

### Prerequisites

The project requires the following tools to be installed on the host machine:

* Docker
* Docker Compose
* GNU Make

Verify your installation before launching the infrastructure:

```bash
docker --version
docker compose version
make --version
```

### Project Structure

The infrastructure is organized around three services:

* **nginx**: reverse proxy handling HTTPS requests
* **wordpress**: PHP-FPM application serving the website
* **mariadb**: database service

Each service contains:

* a dedicated `Dockerfile`
* configuration files (`conf/`)
* initialization scripts (`tools/init.sh`)

```text
srcs/requirements/
├── mariadb
│   ├── Dockerfile
│   └── tools/init.sh
├── nginx
│   ├── Dockerfile
│   ├── conf/nginx.conf
│   └── tools/init.sh
└── wordpress
    ├── Dockerfile
    ├── conf/www.conf
    └── tools/init.sh
```

### Build and Deployment

The entire stack is managed through the project's `Makefile`.

#### Makefile Rules

| Rule     | Description                                      |
| -------- | ------------------------------------------------ |
| `all`    | Builds images and starts the infrastructure      |
| `clean`  | Stops and removes running containers             |
| `fclean` | Removes containers, images, networks and volumes |
| `re`     | Executes `fclean` followed by `all`              |

#### Usage

Start the infrastructure:

```bash
make all
```

Stop the infrastructure:

```bash
make clean
```

Completely remove generated resources:

```bash
make fclean
```

## Data Management

Persistent data is stored through Docker volumes configured in `docker-compose.yml`.

The volumes ensure that:

* WordPress files remain available after container recreation.
* MariaDB data is preserved between restarts.
* Containers can be rebuilt without losing application data.

## Logs & Debugging

### View Service Logs

To inspect logs from a specific container:

```bash
docker compose logs -f nginx
```

```bash
docker compose logs -f wordpress
```

```bash
docker compose logs -f mariadb
```

The `-f` option continuously streams new log entries.

### Container Status

Display the current status of all services:

```bash
docker compose ps
```

### Accessing a Running Container

For debugging purposes:

```bash
docker exec -it nginx sh
```

```bash
docker exec -it wordpress sh
```

```bash
docker exec -it mariadb sh
```

This allows inspection of files, processes, and configuration directly inside the container.

## Rebuilding a Single Service

After modifying a Dockerfile, configuration file, or startup script, rebuild only the affected service:

```bash
docker compose up -d --build <service>
```

Examples:

```bash
docker compose up -d --build nginx
```

```bash
docker compose up -d --build wordpress
```

```bash
docker compose up -d --build mariadb
```

### Recommended Workflow

1. Modify configuration files or Dockerfiles.
2. Rebuild the affected service.
3. Check logs for startup errors.
4. Verify connectivity between containers.
5. Test the website through HTTPS.

```bash
docker compose up -d --build <service>
docker compose logs -f <service>
```
