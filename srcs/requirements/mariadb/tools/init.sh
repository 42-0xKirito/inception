#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mariadbd --user=mysql --skip-networking &
pid=$!

until mariadb-admin ping --silent 2>/dev/null; do
    sleep 1
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "[init] Création de la base et de l'utilisateur..."
    mariadb -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL
    echo "[init] Base initialisée."
else
    echo "[init] Base déjà existante, init SQL skippée."
fi

kill $pid
wait $pid

echo "[init] Démarrage de MariaDB en foreground..."
exec mariadbd --user=mysql --bind-address=0.0.0.0