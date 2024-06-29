#!/bin/bash
# This script builds Website project.

# Exit script if a step fails
set -e
# Set working directiry to script directory
cd "$(dirname "$0")"

echo "==== Website"

# Compile TypeScript

echo "tsc Website"
tsc

# Copy examples
# This assumes the selected examples have been built beforehand.
# Just copy the generated web apps for use in iframes.

echo "Copying example web apps"

# Must remove destination folders first,
# otherwise "cp -r" will behave differently.

rm -rf web/Examples/Benchmark
cp -r ../Examples/Benchmark/web web/Examples/Benchmark

rm -rf web/Examples/Balls
cp -r ../Examples/Balls/web web/Examples/Balls

rm -rf web/Examples/Counter
cp -r ../Examples/Counter/web web/Examples/Counter

rm -rf web/Examples/Todo
cp -r ../Examples/Todo/web web/Examples/Todo

echo "Copying playground"

rm -rf web/Playground/Playground
cp -r ../Playground/web web/Playground/Playground

