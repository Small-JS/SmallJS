CLASS TestCounter EXTENDS Test MODULE TestCounter CLASSVARS '' VARS ''

test
	| counter |

	counter := Counter new.

	self assert: [ counter value = 0 ].

	counter increase increase.
	self assert: [ counter value = 2 ].

	counter reset.
	self assert: [ counter value = 0 ].
!
