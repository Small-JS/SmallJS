#!/bin/bash
# Start Shop Server.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# A SHOP_CLIENT set by the caller (e.g. a client's startServer.sh) overrides the one in .env.
callerClient="$SHOP_CLIENT"
set -o allexport
source .env
if [ -n "$callerClient" ]; then SHOP_CLIENT="$callerClient"; fi
set +o allexport

node out/main.js
