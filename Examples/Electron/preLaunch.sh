#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Copy ./web to ./out"

cp -v web/* out

echo "==== Copy preload.js to *.mjs"

# 2024-09-01:
# The preload.js script is an ESM module (just like the rest)
# The current Electron does needs it to have the *.mjs  extension
# Just copy it to be idempotent and not confuse VSCode.

cp -v out/preload.js out/preload.mjs

# sleep 1
