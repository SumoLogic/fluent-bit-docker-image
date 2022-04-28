#!/bin/bash

set -exuo pipefail

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

REPO_URL=${REPO_URL:-fluent-bit}
source "$CURRENT_DIR/variables.sh"

"$CURRENT_DIR/patch-fluent-bit-version.sh"

docker build \
    --tag "${REPO_URL}:${BUILD_TAG}-${amd64_arch}" \
    --file "Dockerfile.${amd64_arch}" \
    .
