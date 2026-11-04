CLASS TestElectronView EXTENDS Test MODULE TestElectronRenderer CLASSVARS '' VARS ''

"Uses a mock API object on the window, instead of one exposed by a preload script."

async test
	| view result received |

	view := ElectronView new.
	INLINE 'window.testElectronViewApi = {
		echo: ( ...args ) => args,
		typeOf: ( arg ) => typeof arg,
		asyncValue: async () => "async",
		listen: ( callback ) => callback( "event", 42 ) }'.

	"The arguments are passed as raw JS values, so they can pass through the contextBridge."
	result := await view callApi: 'testElectronViewApi' method: 'typeOf' with: 'text'.
	self assert: [ ( String fromJs: result ) = 'string' ].
	result := await view callApi: 'testElectronViewApi' method: 'typeOf' with: 12.
	self assert: [ ( String fromJs: result ) = 'number' ].
	result := await view callApi: 'testElectronViewApi' method: 'echo' with: 'a' with: #( 1 2 ).
	self assert: [ ( Boolean fromJs: INLINE 'result[ 0 ] === "a" && Array.isArray( result[ 1 ] ) && result[ 1 ][ 1 ] === 2' ) ].
	result := await view callApi: 'testElectronViewApi' method: 'echo'.
	self assert: [ ( Integer fromJs: INLINE 'result.length' ) = 0 ].

	"Async API methods are awaited."
	result := await view callApi: 'testElectronViewApi' method: 'asyncValue'.
	self assert: [ ( String fromJs: result ) = 'async' ].

	"The callback block receives the raw JS arguments."
	view callApi: 'testElectronViewApi' method: 'listen' withCallback: [ :name :value |
		received := ( String fromJs: name ), ( Integer fromJs: value ) toString ].
	self assert: [ received = 'event42' ].

	INLINE 'delete window.testElectronViewApi'.
!
