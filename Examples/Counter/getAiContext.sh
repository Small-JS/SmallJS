#!/bin/bash
# Get SmallJS language context file from small-js.org

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "Getting file smalljs.txt from website small-js.org"

src="smalljs.txt"
rm -f $src
curl --silent --output $src "https://small-js.org/"$src

echo "Done."

sleep 2
