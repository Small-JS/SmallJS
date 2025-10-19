# Installing SmallJS prerequisites

To install SmallJS prerequisites, see below.\
To update components, check [Updating](Updating.md)

### Git

On Windows you need this for Git bash to be able to run the *.sh scripts.

Download the latest version here:
> [https://git-scm.com/downloads](https://git-scm.com/downloads)

### Visual Studio Code (VSCode)

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
To fix this, these lines should be added to the FireFox configurations  in  `launch.json`:

        "timeout": 90000,
        "tmpDir": "/some/folder/of/yours/with/write/perms",

### Node.js

SmallJS implements the latest Node.js features
so you should install the latest version, currently V25.x.x, not the LTS version.
Note: There are options for running different Node.js versions side by side.

Download the latest version here:
> [nodejs.org/en/download](https://nodejs.org/en/download)

### TypeScript

To use TypeScript (tsc) from VSCode it needs to be installed globally, with:

`npm -g install typescript`

### OpenGL support (under Linux)

If you see a build error under Linux related to OpenGL, you may need to install it yourself using:
> `sudo apt install libopengl0`
