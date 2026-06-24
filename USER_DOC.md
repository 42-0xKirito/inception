# USER DOCUMENTATION

## Services

The services provided by this stack are :

* A reverse proxy : nginx with TLSv1.3
* A database : mariadb
* A website : wordpress

All service configurations are located in the `srcs/requirements/` directory :

```
srcs/requirements/
├── mariadb
├── nginx
└── wordpress
```

Each service contains its own `Dockerfile`, configuration files, and initialization scripts.

## First launch

Before running anything, make sure the project structure is complete and all required configuration files are present :

```
.
├── Makefile
├── docker-compose.yml
└── srcs
    └── requirements
        ├── mariadb
        ├── nginx
        └── wordpress
```

The stack relies on the Dockerfiles, configuration files, and initialization scripts located inside each service directory.

## Start and stop

To start the stack, run :

```bash
make all
```

This command builds the images defined in the project and starts the containers through `docker-compose.yml`.

To stop :

```bash
make clean
```

To stop and remove all data :

```bash
make fclean
```

## Access and management

When the stack is running, access the WordPress site at :

```
https://<your_login>.42.fr
```

> **SSL warning** : nginx is configured to use TLSv1.3. Depending on your certificate configuration, your browser may display a security warning during the first connection.

> If you're running the stack on a VM or outside the 42 network, make sure `<your_login>.42.fr` resolves correctly (check `/etc/hosts` if needed).

> WordPress administration is available through the standard WordPress dashboard after installation.

## Checks and troubleshooting

Run :

```bash
docker ps
```

to see the state of running containers.

If the site doesn't load :

1. Check that all containers are up with `docker ps`
2. Look at the logs :

```bash
docker compose logs -f nginx
docker compose logs -f wordpress
docker compose logs -f mariadb
```

3. Verify that the configuration files are present :

```text
srcs/requirements/nginx/conf/nginx.conf
srcs/requirements/wordpress/conf/www.conf
```

4. Check that the initialization scripts have executed correctly :

```text
srcs/requirements/nginx/tools/init.sh
srcs/requirements/wordpress/tools/init.sh
srcs/requirements/mariadb/tools/init.sh
```
