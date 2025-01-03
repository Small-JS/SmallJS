#!/bin/bash
# This script builds Shop Client project and runs its tests.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Shop Client"

# Compile TypeScript

echo "tsc Shop Client"
tsc

# Compile Smalltalk

../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t src web/Script

# Check for and run .env file for locations of enabled browsers to test.

if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Skipping browser tests."
	exit 0
fi
source .env

# Start Shop server and remember PID.

if
	! test -f ../Server/.env
then
	echo "Shop Server not configured, .env file missing."
	echo "Skipping tests."
	exit 0
fi

echo "Starting server."
pushd ../Server > /dev/null
set -o allexport
source ../Server/.env
SHOP_CLIENT="../Client/web"
set +o allexport
node --experimental-sqlite out/main.js &
serverPid=$!
popd > /dev/null
sleep 2

# Test in enabled browsers.
# Browsers will close automatically if all tests succeed.
# Otherwise you can inspect the error with the browser dev tools [F12].

if
	[ ! -z "$browserChrome" ]
then
	echo "Starting browser Chrome: "$browserChrome
	sleep 2
	"$browserChrome" http://localhost:3000/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 10
fi
if
	[ ! -z "$browserEdge" ]
then
	echo "Starting browser Edge: "$browserEdge
	sleep 2
	"$browserEdge" http://localhost:3000/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 10
fi
if
	[ ! -z "$browserFirefox" ]
then
	echo "Starting browser Firefox: "$browserFirefox
	sleep 2
	"$browserFirefox" http://localhost:3000/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 10
fi

# Stop web server

echo "Terminating server PID: "$serverPid
kill $serverPid
sleep 2
