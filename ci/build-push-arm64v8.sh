#!/bin/bash

set -exuo pipefail

if ! docker buildx ls | grep 'arm64'
then
    echo "Your Buildx seems to lack arm64 architecture support"
    exit 1
fi

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source "$CURRENT_DIR/variables.sh"

"$CURRENT_DIR/patch-fluent-bit-version.sh"

docker buildx build \
    --push \
    --platform=linux/arm64/v8 \
    --tag "${REPO_URL}:${BUILD_TAG}-${arm64_arch}" \
    --file "Dockerfile.${arm64_arch}" \
    .
