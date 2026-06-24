#!/bin/bash
set -e

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "[init] Génération du certificat SSL..."
    openssl req -x509 -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx.key \
        -out    /etc/ssl/certs/nginx.crt \
        -subj   "/C=FR/ST=Perpignan/O=42/CN=localhost"
fi

echo "[init] Démarrage de NGINX..."
exec nginx -g "daemon off;"