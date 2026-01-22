#!/bin/sh

if [  -d /app/rice-out ]; then
    cp -r /app/riceuser/. /app/rice-out/
    chown -R $(stat -c %U:%G /app/rice-out) /app/rice-out
fi

tail -f /dev/null