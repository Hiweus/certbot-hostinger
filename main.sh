#!/bin/bash

if [ ! -f .env ]; then
  echo "❌ .env file not found. Please create a .env file with your environment variables."
  exit 1
fi

read -p "Enter your email: " email
read -p "Enter your domain (e.g., example.com): " domain

certbot certonly \
  --manual \
  --manual-auth-hook "$(pwd)/auth-hook.sh" \
  --manual-cleanup-hook "$(pwd)/cleanup-hook.sh" \
  --preferred-challenges dns \
  --email "$email" \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --agree-tos \
  --non-interactive \
  --config-dir "$(pwd)/letsencrypt-config" \
  --work-dir "$(pwd)/letsencrypt-work" \
  --logs-dir "$(pwd)/letsencrypt-logs" \
  -d "*.$domain" \
  -d "$domain"

if [ $? -eq 0 ]; then
  echo "✅ Certificate for *.$domain issued successfully!"
  exit 1
else
  echo "❌ Failed to issue certificate."
fi
