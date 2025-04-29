#!/bin/bash
# load_env.sh - Script to load environment variables from .env file
# Usage: source ./scripts/load_env.sh

# Check if .env file exists
ENV_FILE="./.env"
if [ ! -f "$ENV_FILE" ]; then
  # Try parent directory if script is called from scripts/ directory
  ENV_FILE="../.env"
  if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found!"
    return 1
  fi
fi

# Load variables from .env file
echo "Loading environment variables from .env file..."
while IFS= read -r line || [[ -n "$line" ]]; do
  # Skip comments and empty lines
  [[ $line =~ ^#.*$ ]] && continue
  [[ -z "$line" ]] && continue
  
  # Extract variable and value
  if [[ $line =~ ^([A-Za-z0-9_]+)=(.*)$ ]]; then
    key="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"
    
    # Remove quotes if present
    value="${value%\"}"
    value="${value#\"}"
    value="${value%\'}"
    value="${value#\'}"
    
    # Export the variable
    export "$key=$value"
    echo "Exported: $key"
  fi
done < "$ENV_FILE"

echo "Environment variables loaded successfully!"