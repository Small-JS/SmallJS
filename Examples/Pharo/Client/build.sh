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
	! test -f .env
then
	echo "Warning: File missing: '.env' file on Pharo server, skipping tests."
	exit 0
fi

set -o allexport
source .env
set +o allexport

# Check all required variables are set

if [ -z "$pharoVm" ]
then echo "Error: Variable 'pharoVm not set"; exit 1;
fi

if [ -z "$pharoImage" ]
then echo "Error: Variable 'pharoImage not set"; exit 1;
fi

if [ -z "$pharoWeb" ]
then echo "Error: Variable 'pharoWeb not set"; exit 1;
fi

# Start Pharo with config options

if
	[[ $OSTYPE == "darwin"* ]]
then
	open -n $pharoVm --args $pharoImage
else
	$pharoVm $pharoImage &
fi

sleep 8
pharoServerPid=$!

# Test in enabled browsers.
# Browsers will close automatically if all tests succeed.
# Otherwise you can inspect the error with the browser dev tools [F12].

cd ../Client

if
	[ ! -z "$browserChrome" ]
then
	echo "Starting browser Chrome: "$browserChrome
	"$browserChrome" http://localhost:3000/index.html?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi
if
	[ ! -z "$browserEdge" ]
then
	echo "Starting browser Edge: "$browserEdge
	"$browserEdge" http://localhost:3000/index.html?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi
if
	[ ! -z "$browserFirefox" ]
then
	echo "Starting browser Firefox: "$browserFirefox
	"$browserFirefox" http://localhost:3000/index.html?test
	# If browser was already open, startup returns immediately.
	# So sleep the amount of time it needs to finish tests.
	sleep 6
fi

# Stop web server


if
	[[ $OSTYPE == "darwin"* ]]
then
	echo "MacOS: Close Pharo manually."
	# TODO:
	# This does not wort on MacOS since the open command does not give you the PID.
	# You can do some kludge with 'ps' and 'grep', but I'm a bit tired of MacOS right now..
else
	echo "Terminating Pharo server PID: "$pharoServerPid
	kill $pharoServerPid
fi

sleep 2
