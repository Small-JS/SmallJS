#!/bin/bash
# Start node static web server.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# Get config options from file: .env

if [ ! -f ".env" ]
then echo "Error: File '.env' missing, see '.env.example'" ; exit 1;
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
