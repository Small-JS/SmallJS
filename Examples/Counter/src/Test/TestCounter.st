CLASS TestCounter EXTENDS Test MODULE TestCounterClient CLASSVARS '' VARS ''

test
	| counter |

	counter := Counter new.

	self assert: [ counter value = 0 ].

	counter increment increment.
	self assert: [ counter value = 2 ].

	counter reset.
	self assert: [ counter value = 0 ].
!
