#!/bin/bash

set -exuo pipefail

if ! docker buildx ls | grep 'arm/v7'
then
    echo "Your Buildx seems to lack arm/v7 architecture support"
    exit 1
fi

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source "$CURRENT_DIR/variables.sh"

"$CURRENT_DIR/patch-fluent-bit-version.sh"

docker buildx build \
    --push \
    --platform=linux/arm/v7 \
    --tag "${REPO_URL}:${BUILD_TAG}-${arm_arch}" \
    --file "Dockerfile.${arm_arch}" \
    .
