#!/bin/bash

# This script sets up Let's Encrypt SSL certificates for your domains
# Run this script on your production server after configuring domain DNS

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

# Check if domains are provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 domain1.com domain2.com domain3.com"
  echo "Example: $0 autogen.yourdomain.com webui.yourdomain.com openhands.yourdomain.com"
  exit 1
fi

# Install Certbot if not already installed
echo "Checking if Certbot is installed..."
if ! command -v certbot &> /dev/null; then
  echo "Installing Certbot..."
  apt-get update
  apt-get install -y certbot python3-certbot-nginx
fi

# Build domain parameter string for certbot
DOMAIN_PARAMS=""
for domain in "$@"; do
  DOMAIN_PARAMS="$DOMAIN_PARAMS -d $domain"
done

# Obtain certificates
echo "Obtaining certificates for domains: $@"
certbot --nginx $DOMAIN_PARAMS

# Check if certificates were obtained
if [ $? -eq 0 ]; then
  echo "SSL certificates successfully obtained and configured!"
  echo "Restarting Nginx to apply changes..."
  systemctl restart nginx
  echo "Done! Your sites should now be accessible with proper HTTPS"
else
  echo "Failed to obtain certificates. Please check the error messages above."
fi

echo ""
echo "Note: Let's Encrypt certificates expire after 90 days."
echo "Certbot has installed a cron job that will automatically renew your certificates."
echo "You can test the renewal process with: certbot renew --dry-run"