CLASS TestCloseEventOptions EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := CloseEventOptions new.
	self assert: [ options class = CloseEventOptions ].
	self assert: [ options code isNil ].
	self assert: [ options reason isNil ].
	self assert: [ options wasClean isNil ].

	options code: 1000.
	self assert: [ options code = 1000 ].
	options reason: 'Done'.
	self assert: [ options reason = 'Done' ].
	options wasClean: true.
	self assert: [ options wasClean ].
	options cancelable: true.
	self assert: [ options cancelable ].
!
