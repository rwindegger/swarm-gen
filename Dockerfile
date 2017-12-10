FROM alpine:latest

MAINTAINER rene@windegger.wtf

RUN apk --update --no-cache add jq curl bash && rm -rf /var/cache/apk/*

COPY generate-vhosts /usr/bin/generate-vhosts
RUN chmod +x /usr/bin/generate-vhosts

ENTRYPOINT ["/usr/bin/generate-vhosts"]