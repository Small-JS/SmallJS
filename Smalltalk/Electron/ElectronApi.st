CLASS ElectronApi EXTENDS JsObject MODULE ElectronPreload CLASSVARS ''
	VARS 'apiName'

INLINE 'import { contextBridge, ipcRenderer } from "electron";'

"Base class from Electon API "
CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

apiName
	^ apiName.
!
apiName: aName
	apiName := aName.
!
exposeInMainWorld
	INLINE 'contextBridge.exposeInMainWorld( this.apiName.js, this.js )'.
!
addMethod: methodName block: block
	INLINE 'this.js[ methodName.js ] = block.js'.
!
send: methodName
	INLINE 'ipcRenderer.send( methodName.js )'.
!
send: methodName with: data
	INLINE 'ipcRenderer.send( methodName.js, data )'.
!
invoke: methodName with: data then: callback
	INLINE 'ipcRenderer.invoke( methodName.js, data )
		.then( ( result ) => callback( result ) )'.
!
