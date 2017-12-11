FROM alpine:latest

MAINTAINER rene@windegger.wtf

RUN apk --update --no-cache add parallel certbot mariadb-client ruby jq curl bash && rm -rf /var/cache/apk/* && gem install mustache --no-document

COPY generate-vhosts /usr/bin/generate-vhosts
COPY nginx.conf.mustache /etc/swarm-gen/nginx.conf.mustache
COPY haproxy.cfg.mustache /etc/swarm-gen/haproxy.cfg.mustache
COPY host.map.mustache /etc/swarm-gen/host.map.mustache
COPY updatepdns.sql.mustache /etc/swarm-gen/updatepdns.sql.mustache
COPY invalid.http /etc/swarm-gen/invalid.http

RUN chmod +x /usr/bin/generate-vhosts && mkdir -p /etc/nginx/conf.d && mkdir -p /usr/local/etc/haproxy

EXPORT 80

ENTRYPOINT ["/usr/bin/generate-vhosts"]