#!/bin/bash
# This script builds and tests the Pharo Client project.

# Exit script if a step fails.
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Pharo Client"

# Compile TypeScript

echo "tsc Pharo Client"
tsc

# Compile Smalltalk

node ../../../Compiler/out/App.js -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t src web/Script

# Check for and run .env file for locations of enabled browsers to test.

if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Skipping browser tests."
	exit 0
fi
source .env

# Start Pharo server and remember PID.

cd ../Server

if
	! test -f Pharo.image
then
	echo "Warning: File missing: 'Pharo.image', skipping tests."
	exit 0
fi

pharoServer="vm/Pharo Pharo.image"
echo "Starting web server: "$pharoServer
$pharoServer &
pharoServerPid=$!
sleep 4

# Test in enabled browsers.
# Browsers will close automatically if all tests succeed.
# Otherwise you can inspect the error with the browser dev tools [F12].

cd ../Client

if
	[ ! -z "$browserChrome" ]
then
	echo "Starting browser Chrome: "$browserChrome
	sleep 2
	"$browserChrome" http://localhost:3000/index.html?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi
if
	[ ! -z "$browserEdge" ]
then
	echo "Starting browser Edge: "$browserEdge
	sleep 2
	"$browserEdge" http://localhost:3000/index.html?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi
if
	[ ! -z "$browserFirefox" ]
then
	echo "Starting browser Firefox: "$browserFirefox
	sleep 2
	"$browserFirefox" http://localhost:3000/index.html?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi

# Stop web server

echo "Terminating Pharo server PID: "$pharoServerPid
kill $pharoServerPid
sleep 2
