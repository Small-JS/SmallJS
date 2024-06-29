CLASS TestMagnitude EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ ( 1 min: 2 ) = 1 ].
	self assert: [ ( 4 min: 3 ) = 3 ].
	self assert: [ ( 5 max: 6 ) = 6 ].
	self assert: [ ( 8 max: 7 ) = 8 ].
!
