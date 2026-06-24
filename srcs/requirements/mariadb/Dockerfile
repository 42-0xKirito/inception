FROM debian:bookworm

RUN apt update && \
    apt install -y mariadb-server

COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]