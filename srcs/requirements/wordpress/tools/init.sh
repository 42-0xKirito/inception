#!/bin/bash
set -e

WP_PATH="/var/www/html"

echo "[init] Attente de MariaDB sur ${WORDPRESS_DB_HOST}..."

DB_HOST="${WORDPRESS_DB_HOST:-mariadb}"
DB_PORT="${WORDPRESS_DB_PORT:-3306}"

until mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent 2>/dev/null; do
    echo "[init] MariaDB pas encore prête, retry dans 3s..."
    sleep 3
done

echo "[init] MariaDB est prête !"

if [ ! -f "$WP_PATH/wp-login.php" ]; then
    echo "[init] Téléchargement de WordPress..."
    wp core download \
        --path="$WP_PATH" \
        --locale="${WP_LOCALE:-fr_FR}" \
        --allow-root
fi

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "[init] Génération de wp-config.php..."
    wp config create \
        --path="$WP_PATH" \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST:-mariadb}:${WORDPRESS_DB_PORT:-3306}" \
        --allow-root

    wp core install \
        --path="$WP_PATH" \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --path="$WP_PATH" \
        --allow-root
fi

echo "[init] Démarrage de PHP-FPM..."
exec php-fpm8.2 -F