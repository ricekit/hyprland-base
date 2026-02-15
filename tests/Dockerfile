ARG RICEKIT_VERSION=latest
ARG RICEKIT_BASE=ricekit/core
FROM ${RICEKIT_BASE}:${RICEKIT_VERSION}
USER riceuser
WORKDIR /app/riceuser
COPY --chown=riceuser:users . .
RUN /app/setup.sh > /app/setup.log
USER root