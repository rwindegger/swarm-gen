FROM alpine:latest

MAINTAINER rene@windegger.wtf

RUN apk --update --no-cache add ruby jq curl bash && rm -rf /var/cache/apk/* && gem install mustache

COPY generate-vhosts /usr/bin/generate-vhosts
COPY nginx.conf.mustache /etc/swarm-gen/nginx.conf.mustache

RUN chmod +x /usr/bin/generate-vhosts && mkdir -p /etc/nginx/conf.d

ENTRYPOINT ["/usr/bin/generate-vhosts"]