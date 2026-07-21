#!/bin/bash

# Make sure we're in the right directory
cd "$(dirname "$0")"

echo "Checking for .env file..."
if [ ! -f .env ]; then
    echo "ERROR: .env file is missing! Please copy .env.example to .env and fill it out."
    exit 1
fi

echo "Creating acme.json for Traefik Let's Encrypt certificates..."
touch traefik/letsencrypt/acme.json
chmod 600 traefik/letsencrypt/acme.json

echo "Pulling latest Docker images..."
docker-compose pull

echo "Starting/Updating services..."
docker-compose up -d --remove-orphans

echo "Pruning unused Docker images to save disk space..."
docker image prune -af

echo "Deployment complete!"
docker-compose ps
