FROM quay.io/letsencrypt/letsencrypt:latest

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
