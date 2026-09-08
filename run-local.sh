#!/usr/bin/env bash
set -euo pipefail

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker was not found. Install/start Docker, then run this script again."
  exit 1
fi

docker compose up --build
