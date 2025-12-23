CLASS ElectronView EXTENDS JsObject MODULE ElectronRenderer CLASSVARS ''
	VARS ''

"Electron IPC API calls"

"Calling"

callApi: apiName method: methodName
	"Call the Electron IPC API prepared by the exposeInMainWorld method,
	 that added it to the global JS window object."
	INLINE 'window[ apiName.js ][ methodName.js ]()'.
!
callApi: apiName method: methodName with: argument
	"Like above, but with 1 argument."
	INLINE 'window[ apiName.js ][ methodName.js ]( argument )'.
!
callApi: apiName method: methodName with: arg1 with: arg2
	"Like above, but with 2 arguments."
	INLINE 'window[ apiName.js ][ methodName.js ]( arg1, arg2 )'.
!
callApi: apiName method: methodName with: argument then: block
	"Like two above, but evaluate the then: block with the API call result."
	INLINE 'window[ apiName.js ][ methodName.js ]( argument, ( result ) => block.$value$( result ) )'
!
callApi: apiName method: methodName with: arg1 with: arg2 then: block
	"Like above, but with 2 arguments."
	INLINE 'window[ apiName.js ][ methodName.js ]( arg1, arg2, ( result ) => block.$value$( result ) )'
!
testMode
	^ Window default location search toLowerCase = '?test'.
!
