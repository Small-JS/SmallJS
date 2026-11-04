CLASS TestElectronApi EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"The API methods are invoked directly, as the renderer would do through the contextBridge.
 Exposing and IPC only work in the preload script, they are tested live in the test app."

async test
	| api received result |

	api := ElectronApi new.
	api apiName: 'testApi'.
	self assert: [ api apiName = 'testApi' ].

	"Arguments are passed raw, results are converted to raw JS values."
	api addMethod: 'echo' block: [ :text | received := text. String fromJs: text ].
	result := INLINE 'api.js.echo( "Hello" )'.
	self assert: [ ( Boolean fromJs: INLINE 'received === "Hello"' ) ].
	self assert: [ ( Boolean fromJs: INLINE 'result === "Hello"' ) ].

	api addMethod: 'none' block: [ nil ].
	result := INLINE 'api.js.none()'.
	self assert: [ ( Boolean fromJs: INLINE 'result === null' ) ].

	api addMethod: 'array' block: [ #( 1 2 ) ].
	result := INLINE 'api.js.array()'.
	self assert: [ ( Boolean fromJs: INLINE 'Array.isArray( result ) && result[ 1 ] === 2' ) ].

	await self checkAsync: api.
!
async checkAsync: api
	"Async results are converted when they resolve."
	| result |

	api addMethod: 'async' block: [ self asyncText ].
	result := await INLINE 'api.js.async()'.
	self assert: [ ( Boolean fromJs: INLINE 'result === "async"' ) ].
!
async asyncText
	^ 'async'.
!
