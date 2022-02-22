FROM alpine:latest

RUN \
  apk add --update \
  ca-certificates \
  bash \
  git \
  openssh \
  python3 \
  python3-dev \
  py3-pip \
  lftp \
  build-base && \
  pip install --upgrade pip && \
  pip install mkdocs && \
  pip install mkdocs-minify-plugin && \
  pip install mkdocs-material && \
  pip install mkdocs-material-extensions && \
  pip install mkdocs-mermaid2-plugin && \
  pip install mkdocs-git-revision-date-localized-plugin && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

CMD ["sh", "-c", "tail -f /dev/null"]
