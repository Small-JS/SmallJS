
# Exit script if a step fails
# set -e
# Set working directory to script directory
# cd "$(dirname "$0")"

echo -n "Detecting Node.js: "
node -v

# Check minimum version of Node.js

if [[ "$OS" == "Windows_NT" ]]
then
	nodeBin="node.exe"
else
	nodeBin="node"
fi

nodeVersion=`$nodeBin -v`
if [[ "$nodeVersion" != v25.* ]]
then
	echo "Failed: SmallJS requires Node.js with minimum version: V25.0.0"
	exit 1
fi
