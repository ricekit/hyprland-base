#!/bin/bash

for script in /app/script.d/*.sh; do
    if [ -f "$script" ]; then
        source "$script"
    fi
done