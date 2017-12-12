FROM alpine:latest

MAINTAINER rene@windegger.wtf

RUN apk --update --no-cache add parallel certbot py-certifi py-urllib3 py-chardet py-future mariadb-client ruby jq curl bash && rm -rf /var/cache/apk/* && gem install mustache --no-document

COPY generate-vhosts /usr/bin/generate-vhosts
COPY *.mustache *.http /etc/swarm-gen/

RUN chmod +x /usr/bin/generate-vhosts && mkdir -p /etc/nginx/conf.d && mkdir -p /usr/local/etc/haproxy

EXPOSE 80

ENTRYPOINT ["/usr/bin/generate-vhosts"]