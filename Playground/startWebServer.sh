#!/bin/bash
# Start static web server.
# To install: npm install --global http-server

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

http-server web -c-1 -p 3000

