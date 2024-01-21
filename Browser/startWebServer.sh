#!/bin/bash
# Start static web server.
# To install: npm install --global http-server

cd "$(dirname "$0")"
http-server web -c-1 -p 3000

