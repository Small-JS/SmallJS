
# Electron example app

This example app has these 3 standard Electron parts:

	- Node app (main) > class MyElectronApp
	- API (preload) using IPC > class MyElectronApi
	- Browser (renderer) > class MyElectronView

Every class is derived from a base class named without the 'My' part,
that implements standard electron functionality.

The app view has these 3 functions:

	- Color text: Create color text locally within the browser view.
	- Modify title: Modify the title of the Node app.
	- Ping: Send request string 'Ping' to the Node app and display the result: 'Pong'.

To see whats going on inside the Chromium view, thet dev tools are opened by default.\
To debug the main (Node) app part, start the VSCode configuration "Electron: Main".\
To debug the browser (renderer) app part, start the VSCode configuration "Electron: Renderer".\

Note: \
Only the functionality needed for this example is currently implemented in the Electron base classes.\
They are by no means complete yet. If you want to contribute, feel free :).

## Linux - Ubuntu

Ubuntu restricts the use of sandboxes, preventing Electron startup.
To lift this restrictions that execute:

`sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0`
