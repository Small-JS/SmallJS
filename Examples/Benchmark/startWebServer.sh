#!/bin/bash

# Set working directory to script directory.
cd "$(dirname "$0")"

http-server web -c-1 -p 3000
