From alpine:3.8

RUN apk add bash &&\
    wget https://github.com/rancher/cli/releases/download/v2.0.5/rancher-linux-amd64-v2.0.5.tar.gz &&\
    tar -xzf /rancher-linux-amd64-v2.0.5.tar.gz &&\
    mv /rancher-v2.0.5/rancher /usr/local/bin &&\
    rm rancher-linux-amd64-v2.0.5.tar.gz &&\
    rm -rf /rancher-v2.0.5
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["tail","-f","/dev/null"]
