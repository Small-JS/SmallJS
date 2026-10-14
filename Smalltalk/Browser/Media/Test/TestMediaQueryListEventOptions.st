CLASS TestMediaQueryListEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := MediaQueryListEventOptions new.
	self assert: [ options class = MediaQueryListEventOptions ].
	self assert: [ options matches isNil ].
	self assert: [ options media isNil ].
	self assert: [ options bubbles isNil ].

	options matches: true.
	self assert: [ options matches ].
	options media: 'print'.
	self assert: [ options media = 'print' ].

	options := MediaQueryListEventOptions new matches: false; media: 'screen'; cancelable: true.
	self assert: [ options matches not ].
	self assert: [ options media = 'screen' ].
	self assert: [ options cancelable ].
!
