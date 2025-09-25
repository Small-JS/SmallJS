# NW app

This project contains as NW.js application.

NW.js is framework to make multiplatform standalone node applications\
with a GUI that runs in a Chromium browser window, so has full HTML/JS/CSS support.\
These apps can simultaneouly access Node.js features.

Developing NW.js apps is easier than Electron and use less memory,\
because there is only one JS engine running.\
They require ~ twice the memory than say NodeGUI apps,\
but have the advantage running exiting web apps unmodified.

# Installation

To enable debugging NW.js apps in VSCode, install this extension: "Debugger for NWjs"

## Setup from VSCode

It is currently (2025-08-30) not possible to setup the NW.js npm package \
in a multi-platform way that supports launching (debugging) on VSCode.
The issue has been reported here: https://github.com/nwjs/nw.js/issues/8303

The workaround for now is to install NW.js manually in the ./bin folder of the project.

First download NW.js for your OS form here: [https://nwjs.io/downloads](https://nwjs.io/downloads)\
Downloading the SDK version is recommended to be able to debug the app with \[F12\].\
Then extract the downloaden to the ./bin folder,\
making sure that the nw executable (e.g. "nw.exe") is at the highest level.

Note: The script build.sh uses the npm version of Nw.js,\
	so it doesn't require this additional installation.

## MacOS ARM 64 support

2025-08-30: Currently the NWjs version 0.103.0 downloaded from nwjs.io does not work on MacOS (Seqouia) ARM 64.
This is because the app is not signed securely.
The issue has been reported here: https://github.com/nwjs/nw.js/issues/8157

# Running

Now the app can run normally from VSCode or with the ./build.sh script.
