# NodeGui example app

NodeGui is a Node.js library that encapsulates the multi-platform Qt GUI library.\
It enables you to make performant multi-platform, memory efficient desktop apps\
that are easier to implement than Electron apps.

The trade-off is that Qt widgets are different from HTML elements,\
though most styling of them can be done through farmiliar CSS.

## Running

Just open the file `NodeGui.code-workspace` with VSCode and press `[F5]`.

### Runing on Ubuntu

To be able to start NodeGui on the QT 6.6.x platform on Ubuntu 24.04,\
the folowing library needs to be installed manually:

`sudo apt-get install libxcb-cursor0`
