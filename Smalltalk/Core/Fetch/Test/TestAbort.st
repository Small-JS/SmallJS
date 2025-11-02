CLASS TestAbort EXTENDS Test MODULE Core CLASSVARS '' VARS ''

"Tests AbortSignal and AbortController"

testCreation
	|  signal depenentSignal |

	self assertError: [ AbortSignal new ].
	signal := AbortSignal abort.
	self assert: [ signal aborted ].

	depenentSignal := AbortSignal any: #( signal ).
	self assert: [ signal aborted ].
!
testFetchAbort
	| controller requestInit response signal |

	"This test is disabled by default, because the VSCode debugger halts
	on the rejected promise after the intentionally aborted fetch."
	^ self.

	controller := AbortController new.
	requestInit := RequestInit new
		signal: controller signal.

	"Don't await the fetch, but immediately abort it after starting."
	Promise fromJs: ( Fetch request: 'https://jsonplaceholder.typicode.com/posts/1' options: requestInit )
		then: [ :response | self onFetchAbort: response ]
		catch: [ :error | self onFetchAbortError: error ].

	controller abort.
	signal := controller signal.
	self assert: [ signal aborted ].
	self assert: [ signal reason name = 'AbortError' ].
!
onFetchAbort: response
	"This should not be called, the fetch request should have been aborted."
	self Error: 'Fetch was not aborted'.
!
onFetchAbortError: error
	"This error is intended behavior, caused by an aborted fetch."
	self assert: [ error name = 'AbortError' ].
!
testFetchTimedAbort
	| requestInit |

	"This test is disabled by default, because the VSCode debugger halts
	on the rejected promise after the intentionally aborted fetch."
	^ self.

	requestInit := RequestInit new
		signal: ( AbortSignal timeout: 0 ).

	Promise fromJs: ( Fetch request: 'https://jsonplaceholder.typicode.com/posts/1' options: requestInit )
		then: [ :response | self onFetchTimedAbort: response ]
		catch: [ :error | self onFetchTimedAbortError: error ].
!
onFetchTimedAbort: response
	"This should not be called, the fetch request should have been aborted."
	self Error: 'Fetch was not aborted'.
!
onFetchTimedAbortError: error
	"This error is intended behavior, caused by an aborted fetch."
	self assert: [ error name = 'TimeoutError' ].
!
