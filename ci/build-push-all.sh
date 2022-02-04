#!/bin/bash

set -exuo pipefail

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source "$CURRENT_DIR/variables.sh"

"$CURRENT_DIR/patch-fluent-bit-version.sh"

"$CURRENT_DIR/build-push-${amd64_arch}.sh" &
readonly amd64_pid=$!

"$CURRENT_DIR/build-push-${arm_arch}.sh" &
readonly arm_pid=$!

"$CURRENT_DIR/build-push-${arm64_arch}.sh" &
readonly arm64_pid=$!

wait $amd64_pid
wait $arm_pid
wait $arm64_pid

"$CURRENT_DIR/push-multiplatform-manifest.sh"
