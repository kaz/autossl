FROM alpine

RUN apk --no-cache add git bash curl openssl pdns pdns-doc pdns-backend-sqlite3 && \
    git clone --depth 1 https://github.com/lukas2511/dehydrated.git

ADD pdns.conf /etc/pdns
ADD autossl /usr/local/bin

ADD config /dehydrated
ADD hook.sh /dehydrated
ADD domains.txt /dehydrated

EXPOSE 53/tcp 53/udp
VOLUME ["/dehydrated/certs", "/dehydrated/accounts"]

ENTRYPOINT ["autossl"]
