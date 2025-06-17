#!/bin/bash
# This script installs NPM dependencies of the CounterUsingMithril project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Installing NPM packages for: CounterUsingMithril"
npm install

echo "Copy Mithril and Tachyons files from npm packages to web/resources-from-npm"
mkdir -p web/resources-from-npm
cp ./node_modules/mithril/mithril.js web/resources-from-npm/
cp ./node_modules/tachyons/css/tachyons.css web/resources-from-npm/
