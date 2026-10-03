CLASS ElectronView EXTENDS JsObject MODULE ElectronRenderer CLASSVARS ''
	VARS ''

"Electron IPC API calls"

"Calling"

async callApi: apiName method: methodName
	"Call the Electron IPC API prepared by the exposeInMainWorld method,
	 that added it to the global JS window object.
	 Returns the raw result as received through the contextBridge. Async API methods are awaited."
	^ INLINE 'await window[ apiName.js ][ methodName.js ]()'.
!
async callApi: apiName method: methodName with: argument
	"Like above, but with 1 argument."
	^ INLINE 'await window[ apiName.js ][ methodName.js ]( argument )'.
!
async callApi: apiName method: methodName with: arg1 with: arg2
	"Like above, but with 2 arguments."
	^ INLINE 'await window[ apiName.js ][ methodName.js ]( arg1, arg2 )'.
!
callApi: apiName method: methodName withCallback: block
	"Call an API method that calls back later, e.g. to listen for messages from the main process.
	 The block is passed as a JS function and receives the raw JS arguments."
	INLINE 'window[ apiName.js ][ methodName.js ]( ( ...args ) => block.js( ...args ) )'.
!
testMode
	^ Window default location search toLowerCase = '?test'.
!
