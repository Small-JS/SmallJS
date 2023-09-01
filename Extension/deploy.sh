#/bin/bash
# Copies this extension to VSCode extensions folder, where it is automatically used.
DEST=$USERPROFILE"\.vscode\extensions\smalljs"
echo "Current directory:"
pwd
echo "Deploying extension to: "$DEST
read -p "Press [Enter] to start: "
cp -r -v . $DEST
read -p "Press [Enter] to exit: "
