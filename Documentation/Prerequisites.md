# Installing SmallJS prerequisites

To install SmallJS prerequisites, see below.\
To update components, check [Updating](Updating.md)

### GIT

Download the latest version here:
> [https://git-scm.com/downloads](https://git-scm.com/downloads)

### Visual Studio Code

Download the latest version here:
> [https://code.visualstudio.com/download](https://code.visualstudio.com/download)

On MacOS you should add VSCode to the path, this way:\
In VSCode, open the Command Palette (Cmd+Shift+P) type 'shell command' to find:\
`Shell Command: Install 'code' command in PATH command`\
click on to add VSCode to the path.

### VSCode Firefox extension

From Chrome and Edge, step debugging is built into VSCode.
For debugging in Firefox you should install this extension: Debugger for Firefox.

Note:
If you are using Ubuntu with Firefox installed in a Snap container,\
the extension wil not work because it does not have access to the `/tmp` dir.\
To fix this, these lines should be added to the `launch.json` file of your browser projects:

        "timeout": 90000,
        "tmpDir": "/some/folder/of/yours/with/write/perms",

### Node.js

Download the latest version here:
> [nodejs.org/en/download](https://nodejs.org/en/download)

Note 1: To use SQLite database support, install version 22.5.0 or higher.\
Note 2: SmallJS releases are tested on the latest (current) Node.js version, \
so install that if you can, iso the current LTS.

### TypeScript

For TypeScript (tsc) to function *within* VSCode it needs to me installed globally, with:

`npm -g install typescript`

(The build scripts use `npx` to start the TypeScript compiler, so do not need this)

### OpenGL support (under Linux)

If you see a build error under Linux related to OpenGL, you may need to install it yourself using:
> `sudo apt install libopengl0`

