#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

APP_NAME="uv"
REPO="yantonov/alias"

# Detect OS
case "$(uname -s)" in
  Linux*)
    OS="linux"
    ;;
  Darwin*)
    OS="macos"
    ;;
  MINGW*|MSYS*|CYGWIN*)
    OS="windows"
    ;;
  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac

# Get latest tag
LATEST_TAG=$(
  curl -fsSL "https://api.github.com/repos/${REPO}/tags" \
  | jq -r '.[0].name'
)

ARCHIVE_NAME="${APP_NAME}-${OS}-${LATEST_TAG}.tar.gz"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${LATEST_TAG}/${ARCHIVE_NAME}"

echo "Latest tag: ${LATEST_TAG}"
echo "Downloading: ${DOWNLOAD_URL}"

TMP_DIR="$(mktemp -d)"
ARCHIVE_PATH="${TMP_DIR}/${APP_NAME}.tar.gz"

# Download archive
curl -fL "${DOWNLOAD_URL}" -o "${ARCHIVE_PATH}"

# Extract archive
tar -xzf "${ARCHIVE_PATH}" -C "${TMP_DIR}"

# Find binary inside extracted files
BIN_PATH="$(find "${TMP_DIR}" -type f -name "${APP_NAME}*" | head -n1)"

if [[ -z "${BIN_PATH}" ]]; then
  echo "Binary not found in archive"
  exit 1
fi

# Copy binary to current directory
cp "${BIN_PATH}" "./${APP_NAME}"
chmod +x "./${APP_NAME}"

# Cleanup
rm -rf "${TMP_DIR}"

echo "Installed: ./${APP_NAME}"
