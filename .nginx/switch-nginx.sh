#!/bin/bash
set -e

ENV_COLOR=$1 # "blue" or "green"
# This script assumes it's run from a context where it can modify these files.
# For example, from the host system if .nginx directory is mounted into Nginx container,
# or from Jenkins workspace before files are copied to Nginx.

# Define paths relative to the script's location or a known base path.
# For this project, we'll assume it's run from project root or can find .nginx.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
NGINX_FILES_DIR="$SCRIPT_DIR" # .nginx directory

ACTIVE_CONF_PATH="${NGINX_FILES_DIR}/active_upstream.conf"

echo "Switching Nginx to $ENV_COLOR environment"

if [ "$ENV_COLOR" == "blue" ]; then
    echo "Setting active upstream to blue..."
    cp "${NGINX_FILES_DIR}/upstream.blue.conf" "$ACTIVE_CONF_PATH"
    echo "Active Nginx upstream set to blue."
elif [ "$ENV_COLOR" == "green" ]; then
    echo "Setting active upstream to green..."
    cp "${NGINX_FILES_DIR}/upstream.green.conf" "$ACTIVE_CONF_PATH"
    echo "Active Nginx upstream set to green."
else
    echo "Invalid environment color: $ENV_COLOR. Use 'blue' or 'green'."
    exit 1
fi

echo ""
echo "Nginx configuration file '$ACTIVE_CONF_PATH' updated."
echo "The Nginx service now needs to be reloaded to apply these changes."
echo "If Nginx is running in Docker, you might use a command like:"
echo "  docker exec <nginx_container_name_or_id> nginx -s reload"
echo "Or if this script is part of a docker-compose setup, the Nginx container"
echo "should be configured to pick up changes from the mounted 'active_upstream.conf'."
