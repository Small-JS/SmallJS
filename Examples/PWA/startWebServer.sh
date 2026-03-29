#!/bin/bash
# Start static web server on folder: ./web

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo -n "Starting web server in: "
pwd
# Start server on separate port 3010
# to prevent caching conflicts with other websites.
npx http-server web -c-1 -p 3010
