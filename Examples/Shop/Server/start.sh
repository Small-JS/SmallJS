#!/bin/bash
# Start Shop Server. x

cd "$(dirname "$0")"

set -o allexport
source .env
set +o allexport
node out/App.js
