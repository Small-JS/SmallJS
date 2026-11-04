# NW.js example app

This project contains an NW.js application.

NW.js is a framework to make multiplatform standalone Node applications\
with a GUI that runs in a Chromium browser window, so it has full HTML/JS/CSS support.\
These apps can simultaneously access Node.js features.

Developing NW.js apps is easier than Electron and uses less memory,\
because there is only one JS engine running.\
They require ~ twice the memory of, say, NodeGUI apps,\
but have the advantage of running existing web apps unmodified.

# Installation

To enable debugging NW.js apps in VSCode, install this extension: "Debugger for NWjs"

## Setup

Run `./install.sh`. It installs the npm packages, including the SDK flavor of NW.js
(the version ending in `-sdk` in package.json).\
The SDK flavor is needed to debug in VSCode, and to open the dev tools with \[F12\].\
The normal flavor does not open the remote debugging port that the VSCode debugger attaches to.

The npm package downloads NW.js into a folder with the version and platform in its name,\
e.g. `node_modules/nw/nwjs-sdk-v0.119.0-win-x64`.\
So `install.sh` then runs `link-nwjs.js`, which links the folder `./nwjs` to it.\
VSCode starts NW.js from there (see `.vscode/launch.json`).\
See also: https://github.com/nwjs/nw.js/issues/8303

Use `./install.sh` instead of a plain `npm install`, because only `install.sh` creates the `./nwjs` link.\
If the link is missing or points to an old version, run `node link-nwjs.js` to recreate it.

`./update.sh -y` keeps NW.js on the SDK flavor when updating, and then runs `install.sh`.

## MacOS ARM 64 support

If the NW.js SDK does not start on MacOS ARM 64 because the app is not signed securely,\
go to the `./nwjs` folder and execute the command `xattr -rc nwjs.app` .

# Running

- From VSCode: launch configuration "NW" runs and debugs the app,\
	"NW Test" runs and debugs it in test mode. Both compile the Smalltalk code first.
- `./build.sh`: compiles the TypeScript and Smalltalk code, then runs the tests.\
	The window closes automatically after the tests.
- `./start.sh`: runs the app normally, without compiling.
