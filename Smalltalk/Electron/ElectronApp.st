CLASS ElectronApp EXTENDS Object MODULE ElectronMain CLASSVARS '' VARS ''

INLINE 'import { app, BrowserWindow, ipcMain } from "electron";'

"Starting & stopping"

whenReady: block
	INLINE 'app.whenReady().then( () => block.$value() )'.
!
quit
	INLINE 'app.quit()'.
!

"IPC"

on: channel then: block
	INLINE 'ipcMain.on( channel.js, block.js )'.
!
handle: channel then: block
	INLINE 'ipcMain.handle( channel.js, block.js )'.
!

"Testing"

testMode
	^ Process argv length >= 4 and: [ ( Process argv at: 3 ) = '-test' ].
!
