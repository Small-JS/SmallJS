CLASS TestPromise EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| promise |

	promise := Promise new: [ :resolve :reject |
		Timer timeout: 10 then: [
			resolve value: 42 ] ].
	promise then: [ :value | self assert: [ value = 42 ] ].

	promise := Promise resolve: 'ok'.
	promise then: [ :value | self assert: [ value = 'ok' ] ].
	promise finally: [ self assert: [ true ] ].

	"2024-05-15 - Test disabled because of this VSCode bug
	 https://stackoverflow.com/questions/45282653/why-does-vs-code-break-on-handled-exception-from-reject-in-promise"
	"promise := [ Promise reject: 'fail' ] tryCatch: [].
	promise catch: [ :reason | self assert: [ reason = 'fail' ] ]."
!
testCollections
	| promise1 promise2 result |

	promise1 := Promise resolve: 42.
	promise2 := Promise resolve: 'ok'.

	result := Promise all: #( promise1 promise2 ) then: [ :values |
		self assert: [ values = #( 42 'ok' ) ] ].
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
