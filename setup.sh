#!/bin/bash
#
# This script processes the ricing configuration file and loads the necessary modules.

RICING_FILE="/app/riceuser/ricing.yaml"

# This function fetches the source code from a given Git repository URL
# and checks out a specific branch or tag, with optional sparse checkout support.
# Usage: fetch-source <yaml_config_or_url>
# YAML format:
#   url: https://github.com/user/repo
#   tag: main (optional, defaults to main/master)
#   paths: (optional, for sparse checkout)
#     - config/hypr
#     - scripts
fetch_source() {
    local input="$1"
    local url=$(yq -e '.url' <<< "$input" 2>/dev/null || echo "$input" | sed 's/#.*//')
    local tag=$(yq -e '.tag' <<< "$input" 2>/dev/null)
    local paths=$(yq -e '.paths[]' <<< "$input" 2>/dev/null || echo "")
    local repo=$(basename "$url" .git)
    
    # Extract tag from URL if not already set (e.g., https://github.com/user/repo#branch)
    if [ -z "$tag" ] && [[ "$input" == *"#"* ]]; then
        tag=$(echo "$input" | sed -E 's/.*#(.+)$/\1/')
    fi

    # Clone the repository with partial fetching for efficiency
    mkdir -p /app/repos
    cd /app/repos
    
    echo "Cloning $url..."
    if ! git clone --filter=blob:none --no-checkout "$url" 2>/dev/null; then
        echo "Failed to clone repository: $url"
        exit 1
    fi
    
    cd "$repo"
    
    # Determine the branch/tag to checkout
    if [ -z "$tag" ]; then
        # Try to get default branch
        tag=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
        [ -z "$tag" ] && tag="main"
    fi
    
    # Configure sparse checkout if specific paths are provided
    if [ -n "$paths" ]; then
        echo "Configuring sparse checkout for paths: $paths"
        git sparse-checkout init --cone
        git sparse-checkout set $paths
    fi
    
    # Checkout the specified branch or tag
    echo "Checking out $tag..."
    if ! git checkout "$tag" 2>/dev/null; then
        echo "Failed to check out branch or tag: $tag"
        exit 1
    fi
    
    # Copy to destination
    echo "Copying files to /app/riceuser/"
    cp -r . /app/riceuser/
    rm -rf /app/riceuser/.git
    
    echo "Successfully fetched $url (tag: $tag)"
}

# Fetch the extra packages if specified
# apk add --no-cache $(yq e '.extra_packages[]' "$RICING_FILE" || echo "")
# echo "Installed extra packages."
# echo "Setting up ricing from $RICING_FILE"


if [ $(yq '.source' "$RICING_FILE") != "null" ]; then
    fetch_source $(yq '.source' "$RICING_FILE")
fi

# Clone repositories if specified
# It can be just a URL or a map with url and destination
# The branch/tag is specified by appending #branch_or_tag to the URL
for repo_entry in $(yq '.alt_sources[]' "$RICING_FILE"); do
    fetch_source "$repo_entry"
done

echo "Cloned repositories."

WM="$(yq -e '.target' "$RICING_FILE")"

# Source the scripts from script.d
for script in /app/script.d/*.sh; do
    if [ -f "$script" ]; then
        echo "Sourcing $script"
        source "$script"
    fi
done

# Run commands from ricing.yaml
while IFS= read -r cmd; do
    echo "Running command: $cmd"
    eval "$cmd"
done < <(yq '.commands[]' "$RICING_FILE")

echo "Sourced scripts from /app/script.d."