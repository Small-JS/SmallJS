#!/bin/bash
# This script removes all installed / compiled / generated artifacts for this project.

# Change to script folder.
cd "$(dirname "$0")"

echo "Cleaning Website"

rm -fr web/Script
rm -fr web/Playgound/Playground
rm -fr web/Examples/Counter
rm -fr web/Examples/Todo
rm -fr web/Examples/Balls
rm -fr web/Examples/Benchmark
rm -fr web/Examples/WebWorkers
