#!/bin/bash
# Execute start script and wait before closing to see any errors

# Set working directory to script directory.
cd "$(dirname "$0")"

./start.sh

read -p "Press [Enter] to exit: "
