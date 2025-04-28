#!/bin/bash

# Create directory for SSL certificates if it doesn't exist
mkdir -p ../nginx/ssl

# Generate a self-signed wildcard certificate for local development
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ../nginx/ssl/server.key \
  -out ../nginx/ssl/server.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,DNS:*.localhost,DNS:autogen.localhost,DNS:webui.localhost,DNS:openhands.localhost"

# Make copies for each service for compatibility with existing config
cp ../nginx/ssl/server.key ../nginx/ssl/autogen.key
cp ../nginx/ssl/server.crt ../nginx/ssl/autogen.crt
cp ../nginx/ssl/server.key ../nginx/ssl/open-webui.key
cp ../nginx/ssl/server.crt ../nginx/ssl/open-webui.crt
cp ../nginx/ssl/server.key ../nginx/ssl/all-hands.key
cp ../nginx/ssl/server.crt ../nginx/ssl/all-hands.crt

echo "Self-signed certificates generated for local development"