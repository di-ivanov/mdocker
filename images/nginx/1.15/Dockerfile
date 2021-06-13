FROM nginx:1.15-alpine

COPY ./default.conf /etc/nginx/conf.d/
COPY ./ssl /etc/nginx/ssl

RUN apk add openssl && \
    openssl req -x509 -nodes -days 730 \
        -subj  "/C=BG/ST=SF/L=Sofia/O=MDocker/OU=M Docker/CN=mdocker.org" \
        -newkey rsa:2048 -keyout /etc/nginx/ssl/mdocker.key \
        -out /etc/nginx/ssl/mdocker.crt && \
    apk del openssl
