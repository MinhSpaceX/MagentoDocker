FROM nginx:1.24-alpine

ARG APP_ID=1000

RUN addgroup -g "$APP_ID" app \
 && adduser -G app -u "$APP_ID" -h /var/www -s /bin/bash -S app
RUN touch /var/run/nginx.pid
RUN mkdir /sock

RUN apk add --no-cache \
  curl \
  nss-tools \
  openssl

# Make cert if doesn't use Cloudfare 
RUN mkdir -p /etc/nginx/certs \
  && echo -e "\n\n\n\n\n\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.crt
  
COPY ./conf/me2uet.pem /etc/ssl/certs/me2uet.pem
COPY ./conf/privateke_me2uet.key /etc/ssl/private/privateke_me2uet.key 

ARG TARGETARCH

RUN cd /usr/local/bin/ \
  && curl -L https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-$TARGETARCH -o mkcert \
  && chmod +x mkcert

RUN mkdir -p /etc/nginx/sites-available
RUN mkdir -p /etc/nginx/sites-enabled
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/me2uet.io.vn /etc/nginx/sites-available/me2uet.io.vn
RUN ln -s /etc/nginx/sites-available/me2uet.io.vn /etc/nginx/sites-enabled/
RUN [ -f /etc/nginx/sites-enabled/default ] && unlink /etc/nginx/sites-enabled/default || true

RUN mkdir -p /etc/nginx/html /var/www/html \
  && chown -R app:app /etc/nginx /var/www /var/cache/nginx /var/run/nginx.pid /sock

EXPOSE 443

USER app:app

VOLUME /var/www

WORKDIR /var/www/html
