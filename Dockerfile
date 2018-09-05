FROM nginx:mainline-alpine

RUN mkdir -m 777 /v2ray

COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf
COPY server_config.json /v2ray/config.json

RUN apk add ca-certificates curl \
 && chmod +x /entrypoint.sh \
 && chmod g+rwx /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d \
 && chgrp -R root /var/cache/nginx \
 && addgroup nginx root

CMD /entrypoint.sh

USER nginx
