#!/bin/bash

set -exuo pipefail

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source "$CURRENT_DIR/variables.sh"

"$CURRENT_DIR/patch-fluent-bit-version.sh"

docker buildx build \
    --push \
    --platform=linux/amd64 \
    --tag "${REPO_URL}:${BUILD_TAG}-${amd64_arch}" \
    --file "Dockerfile.${amd64_arch}" \
    .
