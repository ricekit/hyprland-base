FROM alpine:3
LABEL org.opencontainers.image.source="https://github.com/ricekit/hyprland-base"
LABEL org.opencontainers.image.description="Base image for Hyprland ricings"
LABEL org.opencontainers.image.licenses="GPL-2.0-only"
LABEL org.opencontainers.image.version="0.0.8"
LABEL org.opencontainers.image.author="Josh Andrews <joshurtree@gmail.com>"

RUN apk add --no-cache sed curl bash
SHELL ["/bin/bash", "-c"]
RUN mkdir /app
ENV HOME=/app/rice-in
WORKDIR /app
COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]