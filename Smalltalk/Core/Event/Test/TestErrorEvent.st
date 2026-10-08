CLASS TestErrorEvent EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| event jsEvent |

	event := ErrorEvent type: 'error'.
	self assert: [ event class = ErrorEvent ].
	self assert: [ event type = 'error' ].
	self assert: [ event message = '' ].

	jsEvent := INLINE 'new ErrorEvent( "error", { message: "Oops", filename: "file.js", lineno: 12, colno: 3, error: new Error( "Oops" ) } )'.
	event := Event fromJsSubEvent: jsEvent.
	self assert: [ event class = ErrorEvent ].
	self assert: [ event message = 'Oops' ].
	self assert: [ event filename = 'file.js' ].
	self assert: [ event lineno = 12 ].
	self assert: [ event colno = 3 ].
	self assert: [ event error notNil ].
!
