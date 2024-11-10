#!/bin/bash
# This script removes all installed / compiled / generated artifacts for this project.

# Change to script folder.
cd "$(dirname "$0")"

echo "Cleaning: Website"

rm -f ./web/App.js*
rm -fr ./web/Examples/Counter
rm -fr ./web/Examples/Todo
rm -fr ./web/Examples/Balls
rm -fr ./web/Examples/Benchmark
rm -fr ./web/Examples/WebWorkers
