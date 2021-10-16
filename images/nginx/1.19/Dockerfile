FROM nginx:1.19-alpine

# Set timezone variable, you can control this from docker-compose
# env DEFAULT_TZ
ARG DOMAIN='magento2.docker'
ENV DEFAULT_DOMAIN ${DOMAIN}

COPY ./default.conf.template /etc/nginx/templates/

RUN apk add openssl && \
    mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 730 \
        -newkey rsa:2048 -keyout /etc/nginx/ssl/mdocker.key \
        -subj  "/C=BG/ST=SF/L=Sofia/O=MDocker/OU=M Docker/CN=magento2.docker" \
        -addext "subjectAltName=DNS:magento2.docker,DNS:*.magento2.docker" \
        -out /etc/nginx/ssl/mdocker.crt && \
    apk del openssl
