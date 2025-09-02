CLASS TestBuffer EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

testCreation
	| buffer |

	self assert: [ Buffer new length = 0 ].
	buffer := Buffer new: 3.
	self assert: [ ( Buffer new: 3 ) length = 3 ].
	self assert: [ ( Buffer new: 3 ) last = 0 ].
	self assert: [ ( Buffer with: 7 ) first = 7 ].
	self assert: [ ( Buffer with: 8 with: 9 ) last = 9 ].

	buffer := Buffer from: 'abc'.
	self assert: [ ( buffer at: 1 ) = 98 ].
!
