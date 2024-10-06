# NodeGui example app

NodeGui is a Node.js library that encapsulates the multi-platform Qt GUI library.\
It enables you to make performant multi-platform, memory efficient desktop apps\
that are easier to implement than Electron apps.

The trade-off is that Qt widgets are different from HTML elements,\
though most styling of them can be done through farmiliar CSS.

## Running

Just open the file `NodeGui.code-workspace` with VSCode and press `[F5]`.

### Runing on Ubuntu 24.04

To be able to start NodeGui on the QT 6.6.x platform on Ubuntu 24.04,\
the folowing library needs to be installed manually:

`sudo apt-get install libxcb-cursor0`

### Runing on macOS

The NPM NodeGui package currently (6-OCT-2024) only loads macOS ARM binaries\
for the modified node engine. `nodegui_core.node`.\
So it will not work on older Intel x64 MacBooks.

If you try, you will get he following error:\
`.../NodeGui/node_modules/@nodegui/nodegui/build/Release/nodegui_core.node'
(mach-o file, but is an incompatible architecture (have (arm64), need (x86_64h)))`

This issues has been reported here: \
https://github.com/nodegui/nodegui/issues/1048

If someone can confirm that it works okay on and ARM MacBook, that would be nice.
