$ErrorActionPreference = "Stop"

Write-Host "Starting Movie Picture Pipeline locally..."
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker was not found. Install/start Docker Desktop, then run this script again."
}

docker compose up --build
