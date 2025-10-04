#!/bin/bash
# This script builds and tests the Counter project.

# Exit script if a step fails.
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Counter"

# Compile TypeScript

echo "tsc Counter"
tsc

# Compile Smalltalk

../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Script

# Check for and run .env file for locations of enabled browsers to test.

if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Skipping browser tests."
	exit 0
fi
source .env

# Start web server

webServer="npx http-server web --port 3000 -c-1 --silent"
echo "Starting web server: "$webServer
$webServer &
sleep 4

# Test in enabled browsers.
# Browsers will close automatically if all tests succeed.
# Otherwise you can inspect the error with the browser dev tools [F12].

if
	[ ! -z "$browserChrome" ]
then
	echo "Starting browser Chrome: "$browserChrome
	sleep 2
	"$browserChrome" --log-level=3 http://localhost:3000/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi
if
	[ ! -z "$browserEdge" ]
then
	echo "Starting browser Edge: "$browserEdge
	sleep 2
	"$browserEdge" --log-level=3 http://localhost:3000/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi
if
	[ ! -z "$browserFirefox" ]
then
	echo "Starting browser Firefox: "$browserFirefox
	sleep 2
	"$browserFirefox" http://localhost:3000/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi

# Stop web server

echo "Terminating web server"
npx kill-port 3000
sleep 2
