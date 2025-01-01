CLASS WebPreferences EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements JS class: BrowserWindowConstructorOptions."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Accessing"

nodeIntegration
	^ Boolean fromJs: INLINE 'this.js.nodeIntegration'.
!
nodeIntegration: nodeIntegration
	INLINE 'this.js.nodeIntegration = nodeIntegration.js'.
!
nodeIntegrationInWorker
	^ Boolean fromJs: INLINE 'this.js.nodeIntegrationInWorker'.
!
nodeIntegrationInWorker: nodeIntegrationInWorker
	INLINE 'this.js.nodeIntegrationInWorker = nodeIntegrationInWorker.js'.
!
nodeIntegrationInSubFrames
	^ Boolean fromJs: INLINE 'this.js.nodeIntegrationInSubFrames'.
!
nodeIntegrationInSubFrames: nodeIntegrationInSubFrames
	INLINE 'this.js.nodeIntegrationInSubFrames = nodeIntegrationInSubFrames.js'.
!
contextIsolation
	^ Boolean fromJs: INLINE 'this.js.contextIsolation'.
!
contextIsolation: contextIsolation
	INLINE 'this.js.contextIsolation = contextIsolation.js'.
!
sandbox
	^ Boolean fromJs: INLINE 'this.js.sandbox'.
!
sandbox: sandbox
	INLINE 'this.js.sandbox = sandbox.js'.
!
preload
	^ String fromJs: INLINE 'this.js.preload'.
!
preload: preload
	INLINE 'this.js.preload = preload.js'.
!
