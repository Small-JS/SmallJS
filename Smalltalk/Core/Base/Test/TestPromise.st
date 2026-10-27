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
async testChaining
	| promise result answer |

	"Promise new: should not assign the new promise to the class object."
	promise := Promise new: [ :resolve :reject | resolve value: 1 ].
	self assert: [ Boolean fromJs: INLINE 'stPromise$class.js === undefined' ].

	result := ( ( Promise resolve: 1 ) then: [ :value | value + 1 ] ) then: [ :value | value * 10 ].
	answer := await result js.
	self assert: [ answer = 20 ].

	"The then block returns a rejected promise instead of throwing an error,
	 because the Firefox debugger halts on errors thrown in promise callbacks,
	 with 'Break on uncaught exceptions' on, even if a chained catch handles them."
	result := ( ( Promise resolve: 1 ) then: [ :value | Promise reject: ( Error new: 'In then' ) js ] )
		catch: [ :error | error message ].
	answer := await result js.
	self assert: [ answer = 'In then' ].

	"The rejection is not reported as unhandled, because catch is chained after then.
	 It is rejected later, so the VSCode debugger does not halt on it, unlike in testCatch."
	promise := Promise new: [ :resolve :reject |
		Timer timeout: 10 then: [ reject value: ( Error new: 'Rejected' ) js ] ].
	result := Promise fromJs: promise js
		then: [ :value | 'Not reached' ]
		catch: [ :error | error message ]
		finally: [ self onFinally ].
	answer := await result js.
	self assert: [ answer = 'Rejected' ].
!
async testAwait
	| promise answer |

	"A Promise can be awaited directly, without sending js."
	promise := Promise new: [ :resolve :reject |
		Timer timeout: 10 then: [ resolve value: 42 ] ].
	answer := await promise.
	self assert: [ answer = 42 ].

	answer := await ( ( Promise resolve: 1 ) then: [ :value | value + 1 ] ).
	self assert: [ answer = 2 ].

	"Being thenable does not add a property to Promise objects."
	self assert: [ promise keys = #( 'js' ) ].
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
