#!/bin/bash
# Start node static web server.
cd "$(dirname "$0")"
pwd
http-server web -c-1 -p 3000
