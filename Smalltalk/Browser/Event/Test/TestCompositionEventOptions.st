CLASS TestCompositionEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := CompositionEventOptions new.
	self assert: [ options class = CompositionEventOptions ].
	self assert: [ options data isNil ].
	options data: 'ni'.
	self assert: [ options data = 'ni' ].

	"Inherited options"
	options detail: 2; cancelable: true.
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
