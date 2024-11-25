#!/bin/bash
# Start node static web server.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo -n "Directory: "
pwd
http-server web -c-1 -p 3000
