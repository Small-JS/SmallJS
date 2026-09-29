CLASS ElectronApp EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"INLINE 'import { app, BrowserWindow, ipcMain } from 'electron';'"
INLINE 'import * as electron$ from "electron";'


"Implements Electron JS object: app.
 Note: Platform specific funcionality is not implemented, keeping it standard."

CLASSMETHODS

new
	^ self fromJs: INLINE 'electron$.app'.
!

METHODS
"Starting & stopping"

whenReady: block
	INLINE 'this.js.whenReady().then( () => block.$value() )'.
!
isReady
	^ Boolean fromJs: INLINE 'this.js.isReady()'.
!
quit
	INLINE 'this.js.quit()'.
!
exit
	INLINE 'this.js.exit()'.
!
exit: exitCode
	INLINE 'this.js.exit( exitCode.js )'.
!
relaunch
	"Note: This does not quit the app, call #quit or #exit after this."
	INLINE 'this.js.relaunch()'.
!
focus
	INLINE 'this.js.focus()'.
!

"App events"

onAppEvent: event then: block
	"Note: The block receives the JS arguments of the event."
	INLINE 'this.js.on( event.js, block.js )'.
!
onceAppEvent: event then: block
	"Note: The block receives the JS arguments of the event."
	INLINE 'this.js.once( event.js, block.js )'.
!

"Information"

getName
	^ String fromJs: INLINE 'this.js.getName()'.
!
setName: name
	INLINE 'this.js.setName( name.js )'.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
getVersion
	^ String fromJs: INLINE 'this.js.getVersion()'.
!
getLocale
	"Note: Only valid after the app is ready."
	^ String fromJs: INLINE 'this.js.getLocale()'.
!
getLocaleCountryCode
	^ String fromJs: INLINE 'this.js.getLocaleCountryCode()'.
!
getSystemLocale
	"Note: Only valid after the app is ready."
	^ String fromJs: INLINE 'this.js.getSystemLocale()'.
!
getPreferredSystemLanguages
	^ Array fromJsStrings: INLINE 'this.js.getPreferredSystemLanguages()'.
!
getApplicationNameForProtocol: url
	^ String fromJs: INLINE 'this.js.getApplicationNameForProtocol( url.js )'.
!
userAgentFallback
	^ String fromJs: INLINE 'this.js.userAgentFallback'.
!
userAgentFallback: userAgent
	INLINE 'this.js.userAgentFallback = userAgent.js'.
!

"Paths"

getAppPath
	^ String fromJs: INLINE 'this.js.getAppPath()'.
!
getPath: name
	"Name is one of: 'home', 'appData', 'assets', 'userData', 'sessionData', 'temp', 'exe', 'module',
	 'desktop', 'documents', 'downloads', 'music', 'pictures', 'videos', 'recent', 'logs', 'crashDumps'."
	^ String fromJs: INLINE 'this.js.getPath( name.js )'.
!
setPath: name path: path
	INLINE 'this.js.setPath( name.js, path.js )'.
!
setAppLogsPath
	INLINE 'this.js.setAppLogsPath()'.
!
setAppLogsPath: path
	INLINE 'this.js.setAppLogsPath( path.js )'.
!

"Single instance"

requestSingleInstanceLock
	^ Boolean fromJs: INLINE 'this.js.requestSingleInstanceLock()'.
!
hasSingleInstanceLock
	^ Boolean fromJs: INLINE 'this.js.hasSingleInstanceLock()'.
!
releaseSingleInstanceLock
	INLINE 'this.js.releaseSingleInstanceLock()'.
!

"Hardware acceleration & sandbox"

disableHardwareAcceleration
	"Note: Can only be called before the app is ready."
	INLINE 'this.js.disableHardwareAcceleration()'.
!
isHardwareAccelerationEnabled
	^ Boolean fromJs: INLINE 'this.js.isHardwareAccelerationEnabled()'.
!
enableSandbox
	"Note: Can only be called before the app is ready."
	INLINE 'this.js.enableSandbox()'.
!

"Network"

resolveProxy: url then: block error: errorBlock
	INLINE 'this.js.resolveProxy( url.js )
		.then( ( proxy ) => block.$value$( stString$class.$fromJs$( proxy ) ) )
		.catch( ( error ) => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!

"IPC"

on: channel then: block
	INLINE 'electron$.ipcMain.on( channel.js, block.js )'.
!
handle: channel then: block
	INLINE 'electron$.ipcMain.handle( channel.js, block.js )'.
!

"Testing"

testMode
	^ Process argv includes: '-test'.
!
