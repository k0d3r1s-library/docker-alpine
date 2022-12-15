FROM    simpletoimplement/alpine:edge as builder

RUN     \
        set -eux \
&&      apk upgrade --no-cache --update --no-progress --available -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
&&      mkdir -p /home/vairogs \
&&      addgroup -S -g 1000 vairogs \
&&      adduser -S -u 1000 -G vairogs -D -s /bin/bash -h /home/vairogs vairogs \
&&      update-ca-certificates \
&&      echo 'alias ll="ls -lah"' >> /home/vairogs/.bashrc \
&&      echo 'alias vim="vi"' >> /home/vairogs/.bashrc \
&&      echo 'alias ll="ls -lah"' >> /root/.bashrc \
&&      echo 'alias vim="vi"' >> /root/.bashrc \
&&      rm -rf \
            /var/apk/* \
            /tmp/* \
&&      chown -R vairogs:vairogs /home/vairogs

FROM    scratch

COPY    --from=builder / /

LABEL   maintainer="support+docker@vairogs.com"
ENV     container=docker

SHELL   ["/bin/bash", "-o", "pipefail", "-c"]

USER    vairogs

CMD     ["/bin/bash"]
