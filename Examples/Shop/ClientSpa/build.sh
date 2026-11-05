#!/bin/bash
# This script builds Shop Client project and runs its tests.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Building: Example Shop Client SPA"

# Compile TypeScript

echo "tsc Shop ClientSpa"
tsc

# Compile Smalltalk

../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t ../Shared src web/Script

# Check for and run .env file for locations of enabled browsers to test.

if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Skipping browser tests."
	exit 0
fi
source .env

# Start Shop server, serving this client.

if
	! test -f ../Server/.env
then
	echo "Shop Server not configured, .env file missing."
	echo "Skipping tests."
	exit 0
fi

pushd ../Server > /dev/null
set -o allexport
source .env
SHOP_CLIENT="../ClientSpa/web"
set +o allexport

# Do not test against (and afterwards terminate) a server that is already running.
if
	curl -s -o /dev/null "http://localhost:$SHOP_PORT/"
then
	echo "Error: port $SHOP_PORT is already in use. Stop the running server first."
	exit 1
fi

echo "Starting Shop server on port $SHOP_PORT."
node out/main.js &
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
	"$browserChrome" --log-level=3 http://localhost:$SHOP_PORT/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 10
fi
if
	[ ! -z "$browserEdge" ]
then
	echo "Starting browser Edge: "$browserEdge
	sleep 2
	"$browserEdge" --log-level=3 http://localhost:$SHOP_PORT/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 10
fi
if
	[ ! -z "$browserFirefox" ]
then
	echo "Starting browser Firefox: "$browserFirefox
	sleep 2
	"$browserFirefox" http://localhost:$SHOP_PORT/?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 10
fi

# Stop Shop server

echo "Terminating Shop server"
npx kill-port $SHOP_PORT
sleep 2
