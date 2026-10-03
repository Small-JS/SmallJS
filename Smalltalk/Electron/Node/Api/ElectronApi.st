CLASS ElectronApi EXTENDS JsObject MODULE ElectronPreload CLASSVARS ''
	VARS 'apiName'

"Base class for Electron API."

INLINE 'import * as electron$ from "electron";'

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

apiName
	^ apiName.
!
apiName: anApiName
	apiName := anApiName.
!
exposeInMainWorld
	INLINE 'electron$.contextBridge.exposeInMainWorld( this.apiName.js, this.js )'.
!
addMethod: methodName block: block
	INLINE 'this.js[ methodName.js ] = block.js'.
!
send: methodName
	INLINE 'electron$.ipcRenderer.send( methodName.js )'.
!
send: methodName with: data
	INLINE 'electron$.ipcRenderer.send( methodName.js, data )'.
!
async invoke: methodName with: data
	"Returns the result of the ipcMain handler as a raw JS value,
	 so it can be passed on through the contextBridge."
	^  INLINE 'await electron$.ipcRenderer.invoke( methodName.js, data )'.
!
on: channel then: callback
	"Calls callback with the raw JS arguments of each message the main process sends on channel,
	 e.g. with ElectronWebContents>>send:with:. The IPC event argument is not passed,
	 because it cannot be passed through the contextBridge.
	 Note: Callback is a raw JS function, e.g. received through the contextBridge from the renderer."
	INLINE 'electron$.ipcRenderer.on( channel.js, ( event, ...args ) => callback( ...args ) )'.
!
