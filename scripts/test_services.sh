#!/bin/bash

# Test script to verify services are responding
echo "Testing services via HTTP requests..."
echo "=============================================="
echo ""

# Function to test a service
test_service() {
  local name="$1"
  local url="$2"
  local expected_code="$3"
  
  echo "Testing $name at $url"
  echo "---------------------------------------------"
  
  # Make HTTP request with curl and output status code
  status_code=$(curl -s -o /dev/null -w "%{http_code}" -k "$url")
  
  if [ "$status_code" = "$expected_code" ]; then
    echo "✅ SUCCESS: $name returned status code $status_code (expected: $expected_code)"
  else
    echo "❌ FAILED: $name returned status code $status_code (expected: $expected_code)"
    
    # If failed, show verbose output for debugging
    echo "Detailed curl output for debugging:"
    curl -v -k "$url" 2>&1 | grep -v "^{" | grep -v "^}"
  fi
  
  echo ""
}

# Parse command line arguments
SERVICE="all"
if [ "$1" != "" ]; then
  SERVICE="$1"
fi

echo "Testing service(s): $SERVICE"
echo ""

# Test selected service or all services
if [ "$SERVICE" == "all" ] || [ "$SERVICE" == "open-webui" ]; then
  echo "--- Testing Open WebUI ---"
  test_service "Open WebUI direct" "http://localhost:3000" "200"
  test_service "Open WebUI via Nginx (HTTP)" "http://webui.localhost" "301"
  test_service "Open WebUI via Nginx (HTTPS)" "https://webui.localhost" "200"
  echo ""
fi

if [ "$SERVICE" == "all" ] || [ "$SERVICE" == "autogen" ]; then
  echo "--- Testing AutoGen Studio ---"
  test_service "AutoGen Studio direct" "http://localhost:5000" "200"
  test_service "AutoGen Studio via Nginx (HTTP)" "http://autogen.localhost" "301"
  test_service "AutoGen Studio via Nginx (HTTPS)" "https://autogen.localhost" "200"
  echo ""
fi

if [ "$SERVICE" == "all" ] || [ "$SERVICE" == "all-hands" ]; then
  echo "--- Testing All-Hands ---"
  test_service "All-Hands direct" "http://localhost:8000" "200"
  test_service "All-Hands via Nginx (HTTP)" "http://openhands.localhost" "301"
  test_service "All-Hands via Nginx (HTTPS)" "https://openhands.localhost" "200"
  echo ""
fi

echo "=============================================="
echo "Tests completed"