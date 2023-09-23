#!/bin/bash
# This script builds all SmallJS components and and tests where possible from the command line.

# Exit script if a step fails
set -e

if test -f 'zzzz'
then echo "exists"
else echo "not exsists"
	causeError
fi
echo "end script"