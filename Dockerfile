FROM alpine:3
LABEL org.opencontainers.image.source="https://github.com/ricekit/hyprland-base"
LABEL org.opencontainers.image.description="Base image for Hyprland ricings"
LABEL org.opencontainers.image.licenses="GPL-2.0-only"
LABEL org.opencontainers.image.version="0.0.8"
LABEL org.opencontainers.image.author="Josh Andrews <coding@joshandrews.xyz>"

RUN apk add --no-cache sed curl bash
RUN mkdir -p /app/riceuser
RUN adduser riceuser --shell /bin/bash --disabled-password --gecos "" --home /app/riceuser
WORKDIR /app
COPY script.d /app/script.d
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]