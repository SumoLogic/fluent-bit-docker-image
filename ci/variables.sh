#!/bin/bash

set -exuo pipefail

readonly amd64_arch=x86_64
readonly arm_arch=arm32v7
readonly arm64_arch=arm64v8
readonly default_repo_url=public.ecr.aws/sumologic/fluent-bit

REPO_URL=${REPO_URL:-$default_repo_url}

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BUILD_TAG=${BUILD_TAG:-$("$CURRENT_DIR/get-build-tag.sh")}
