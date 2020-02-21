FROM alpine:3.9

MAINTAINER rene@windegger.wtf

RUN apk --update --no-cache add certbot py2-certifi py2-urllib3 py2-chardet py2-future mariadb-client ruby jq curl bash && rm -rf /var/cache/apk/* && gem install mustache --no-document

COPY generate-vhosts /usr/bin/generate-vhosts
COPY *.mustache /etc/swarm-gen/

RUN chmod +x /usr/bin/generate-vhosts && mkdir -p /usr/local/etc/haproxy

EXPOSE 80

ENTRYPOINT ["/usr/bin/generate-vhosts"]
