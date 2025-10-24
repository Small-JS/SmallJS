CLASS TestPromise EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| promise |

	promise := Promise new: [ :resolve :reject |
		Timer timeout: 10 then: [ resolve value: 42 ] ].
	promise then: [ :value | self assert: [ value = 42 ] ].

	promise := Promise resolve: 'ok'.
	promise then: [ :value | self assert: [ value = 'ok' ] ].
	promise finally: [ self assert: [ true ] ].
!
testCollections
	| promise1 promise2 result |

	promise1 := Promise resolve: 42.
	promise2 := Promise resolve: 'ok'.

	result := Promise all: #( promise1 promise2 )
		then: [ :values | self assert: [ values = #( 42 'ok' ) ] ].
	self assert: [ result class = Promise ].

	result := Promise allSettled: #( promise1 promise2 ) then: [ :promiseStatuses |
		self assert: [ promiseStatuses length = 2 ].
		self assert: [ promiseStatuses first status = 'fulfilled' ].
		self assert: [ promiseStatuses first value = 42 ] ].
	self assert: [ result class = Promise ].

	result := Promise any: #( promise1 promise2 )
		then: [ :value | self assert: [ value = 42 ] ].
	self assert: [ result class = Promise ].

	result := Promise race: #( promise1 promise2 )
		then: [ :value | self assert: [ value = 42 ] ].
	self assert: [ result class = Promise ].
!
async testAsyncAwait
	| result |
	result := await self asyncMethod.
	self assert: [ result = 'asyncMethodResult' ].
!
async asyncMethod
	"Await here shows the intended use,
	but it does not do anything on constants."
	^ await 'asyncMethodResult'.
!
testThenFinally
	| promise1 promise2 |

	promise1 := Promise resolve: 'resolved'.
	promise2 := Promise fromJs: promise1 js
		then: [ :result | self onThen: result ]
		catch: [ :result | self onCatch: result ]
		finally: [  self onFinally ].
!
onThen: result
	self assert: [ result = 'resolved' ].
!
onCatch: error
	"Error handling here shows the intended use,
	but this method should not be reached."
	error throw.
!
onFinally
	"This method should be reached."
	self assert: [ true ].
!
testCatch
	| promise1 promise2 |

	"This test is disabled by default because it halts the VSCode debugger.
	It can be enabled to check that 'onExpectedCatch:' is called after continuing with [F5]."
	^ self.

	promise1 := Promise reject: 'rejected'.
	promise2 := Promise fromJs: promise1 js
		then: [ :result | self onThen: result ]
		catch: [ :result | self onExpectedCatch: result ]
		finally: [  self onFinally ].
!
onExpectedCatch: reason
	self assert: [ reason = 'rejected' ].
!
