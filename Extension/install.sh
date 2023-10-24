#!/bin/bash
# This script installs the VSCode smalljs extension into VSCode

cd "$(dirname "$0")"

echo "==== Intalling SmallJS language extension in VSCode"

# Find VSCode installation folder

if
	[[ -n "$HOME" ]]
then
	DEST=$HOME
else
	DEST=$USERPROFILE
fi

if
	[ -z "$DEST" ]
then
	echo "Error: Environment variable HOME or USERPROFILE not set."
	exit 1
fi

# Copy SmallJS extension to VSCode extensions folder

DEST=$DEST"/.vscode/extensions"
if
	[ ! -d "$DEST" ]
then
	echo "Error: VSCode extensions folder does not exist: "$DEST
	exit 1
fi

DEST=$DEST"/smalljs"
echo "Copying language extension to: "$DEST
if
	! cp -r . $DEST
then
	echo "Error: Copy SmallJS language extension to VSCode failed."
	exit 1
fi
