#!/bin/bash
# This script builds and tests all SmallJS components ss far as is possible from the command line.
# No browsers are started.
# This script must be run in the root folder of the SmallJS repo.
echo -n "Current dir: "
pwd
pushd . > /dev/null
if
	echo -n "Detecting VSCode: "
	! code -v
then
	echo "Error: Visual Studio Code 'code' not detected."
else if
	echo -n "Detecting tsc: "
	! tsc -v
then
	echo "Error: TypeScript compiler 'tsc' not detected."
else if
	echo -n "Detecting node: "
	! node -v
then
	echo "Error: Node.js 'node' not detected."
else if
	echo -n "Detecting npm: "
	! npm -v
then
	echo "Error: NPM not detected."
else if
	echo "==== Extension"
	! [[ -n "$USERPROFILE" ]]
then
	echo "Error: Environment variable USERPROFILE not set."
else if
	DEST=$USERPROFILE"\.vscode\extensions\smalljs"
	echo "Copying extension to: "$DEST
	! cp -r -u ./Extension $DEST
then
	echo "Error: Copy SmallJS language extension to VSCode failed."
else if
	echo "==== Compiler"
	! cd ./Compiler
then
	echo "Error: ./Compiler dir for found."
else if
	echo "Installing NPM packages"
	! npm install --silent
then
	echo "Error: npm install failed."
else if
	echo "tsc Compiler"
	! tsc
then
	echo "Error: Compiler TypeScript compilation failed."
else if echo "==== Node"
	! cd ../Node
then
	echo "Node dir for found."
else if
	echo "Installing NPM packages"
	! npm install --silent
then
	echo "Error: npm install failed."
else if echo "tsc Node"
	! tsc
then
	echo "Error: Node TypeScript compilation failed."
else if
	! node ../Compiler/out/App.js ../Smalltalk/Core ../Smalltalk/Node src out
then
	echo "Node Smalltalk compilation failed."
else if
	if
		! test -f .env
	then
		echo "Warning: ./Node/.env file missing. See ./Node/.env.example ."
	fi
	set -o allexport
	source .env
	set +o allexport
	! node out/App.js
then
	echo "Node unit tests failed."
else if
	echo "==== Browser"
	! cd ../Browser
then
	echo "Browser dir for found."
else if
	! node ../Compiler/out/App.js ../Smalltalk/Core ../Smalltalk/Browser src web/Smalltalk
then
	echo "Browser Smalltalk compilation failed."
else if
	echo "==== Shop Server"
	! cd ../Shop/Server
then
	echo "Shop Server dir for found."
else if
	echo "Installing NPM packages"
	! npm install --silent
then
	echo "Error: npm install failed."
else if
	if
		! test -f .env
	then
		echo "Warning: ./Shop/Server/.env file missing. See ./Shop/Server/.env.example ."
	fi
	set -o allexport
	source .env
	set +o allexport
	! node ../../Compiler/out/App.js ../../Smalltalk/Core ../../Smalltalk/Node src out
then
	echo "Shop Server Smalltalk compilation failed."
else if
	echo "==== Shop Client"
	! cd ../Client
then
	echo "Shop Client dir for found."
else if
	! node ../../Compiler/out/App.js ../../Smalltalk/Core ../../Smalltalk/Browser src web/Smalltalk
then
	echo "Shop Client Smalltalk compilation failed."
else
	echo "==== All builds & tests succesful."
fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi ; fi
popd > /dev/null
read -p "Press [Enter] to exit: "
