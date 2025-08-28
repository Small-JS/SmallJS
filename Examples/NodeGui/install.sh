#!/bin/bash
# This script installs npm dependencies of this project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# Check for MacOs on ARM, for which there is currently no precompiled NodeGui binary.

if
	test `uname` = "Darwin" && test `uname -m` != "x86_64"
then
	echo "NodeGui MacOS ARM support is currently limited (2025-02-08), exiting."
	exit 0;
fi

echo "==== Installing npm packages for: Example NodeGui"
npm install
