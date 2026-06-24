FROM debian:bookworm

RUN apt update && apt install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 443

CMD ["/init.sh"]