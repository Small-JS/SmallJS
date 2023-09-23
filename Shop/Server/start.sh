#!/bin/bash
# Start Shop Server

cd "$(dirname "$0")"

set -o allexport
source .env
set +o allexport
node out/App.js
