#!/bin/bash
# Start static web server as Shop Server.
# Can be used for HTML testing.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

http-server web -c-1 -p 3000
