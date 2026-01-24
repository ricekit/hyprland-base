#!/bin/sh
#
# This script processes the ricing configuration file and loads the necessary modules.

set -e
RICING_FILE="/app/riceuser/ricing.yaml"

# Fetch the extra packages if specified
apk add --no-cache $(yq e '.extra_packages[]' "$RICING_FILE" || echo "")

# Clone repositories if specified
# It can be just a URL or a map with url and destination
# The branch/tag is specified by appending #branch_or_tag to the URL
yq e '.repositories[]' "$RICING_FILE" | while read -r repo_entry; do
    source=$(echo "$repo_entry" | yq e '.source' -)
    repo_url=$(echo "$source" | cut -d'#' -f1)
    branch_or_tag=$(echo "$source" | grep -oP '(?<=#).*$' || echo "")
    dest_dir=$(yq e '.destination' <<< "$repo_entry" || echo "")
    ./fetch-source.sh "$repo_url" "$branch_or_tag" "$dest_dir"
done

# Install scripts to script.d directory
yq e '.scripts[]' "$RICING_FILE" | while read -r script_url; do
    if [ $(grep -c '^https\?://' <<< "$script_url") -neq 0 ]; then
        script_name=$(basename "$script_url")
        curl -fsSL "$script_url" -o "/app/script.d/$script_name"
    else
        script_name=$(basename "$script_url")
        mv "$script_url" "/app/script.d/$script_name"
    fi
    chmod +x "/app/script.d/$script_name"
done

# Source the scripts from script.d
for script in /app/script.d/*.sh; do    
    if [ -f "$script" ]; then
        source "$script"
    fi
done