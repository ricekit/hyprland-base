FROM alpine:3
LABEL org.opencontainers.image.source="https://github.com/ricekit/core"
LABEL org.opencontainers.image.description="Base image for ricings distributed via ricekit"
LABEL org.opencontainers.image.licenses="GPL-2.0-only"
LABEL org.opencontainers.image.version="0.0.9"
LABEL org.opencontainers.image.author="Josh Andrews <coding@joshandrews.xyz>"

RUN apk update && apk upgrade
RUN apk add --no-cache sed curl bash yq git rsync
RUN mkdir -p /app/riceuser
RUN adduser riceuser --disabled-password --gecos "" --home /app/riceuser --shell /bin/bash
WORKDIR /app
COPY . .
RUN chown riceuser:riceuser /app
