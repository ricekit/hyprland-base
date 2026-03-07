#!/bin/bash
# A simple test script to verify the functionality of a sample application

# Ensure that we are in the correct directory
cd "$(dirname "$0")" || exit 1

RICEKIT_DIR="../../ricekit"
DOCKERFILE="$RICEKIT_DIR/resources/Dockerfile"
TEST_RICINGS_DIR="$RICEKIT_DIR/tests/ricings"
# Check if ricekit is available in the parent directory
if [ -r "$DOCKERFILE" ] && [ -d "$TEST_RICINGS_DIR" ]; then
    echo "Ricekit found in parent directory, using it for testing."
else
    echo "Ricekit not found in parent directory. Please ensure that ricekit is available for testing."
    exit 1
fi

if [ $# -eq 0 ]; then
    ricings=$(ls "$TEST_RICINGS_DIR"/*.yaml -1 | xargs -n 1 basename | sed 's/\.yaml$//')
else
    # Get the list of files from command line arguments excluding arguments starting with --
    ricings=$(echo "$@" | sed 's/--[a-zA-Z]*//g')
fi

if docker build -t test-base:latest -f ../Dockerfile --rm ..; then
    echo "Base image built successfully."
else
    echo "Failed to build base image."
    exit 1
fi

echo -e "Running tests in directories:\n $ricings"

for ricing in $ricings; do
    mkdir -p "build/$ricing"
    cp $TEST_RICINGS_DIR/$ricing.yaml build/$ricing/ricing.yaml
    cp -r $TEST_RICINGS_DIR/* build/$ricing/
    # if the docker image for this directory already exists, delete it
    image=test-image-$ricing:latest
    if docker image inspect $image > /dev/null 2>&1; then
        docker rmi $image --force
    fi
    echo "Running test in $(realpath "build/$ricing")"
    if docker build -t $image -f "$DOCKERFILE" "build/$ricing" --build-arg REPO="" --build-arg RICEKIT_BASE=test-base --build-arg RICEKIT_VERSION=latest; then
        echo "Image built successfully for $ricing."
    else
        echo "Failed to build image for $ricing."
        exit 1
    fi
    RESULT="./result/$ricing"
    rm -rf "$RESULT"
    mkdir -p "$RESULT"

    # Copy files from container to host
    CONTAINER=$(docker create -v "$(realpath "$RESULT"):/app/rice-out" $image)
    docker start -a $CONTAINER > "$RESULT/setup.log"
    docker rm $CONTAINER --force
    echo "Test completed for $ricing, results are in $RESULT"

    if [[ " ${@} " =~ " --keep " ]]; then
        echo "Keeping test-image as per --keep flag."
    else
        docker rmi $image --force
    fi
    rm -rf "build/$ricing"
done
docker rmi test-base:latest --force