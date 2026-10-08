CLASS TestCustomEventOptions EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := CustomEventOptions new.
	self assert: [ options class = CustomEventOptions ].
	self assert: [ options detail isNil ].
	self assert: [ options bubbles isNil ].

	options detail: 'Hello'.
	self assert: [ ( String fromJs: options detail js ) = 'Hello' ].
	options detail: 42.
	self assert: [ ( Integer fromJs: options detail js ) = 42 ].
	options bubbles: true.
	self assert: [ options bubbles ].
!
