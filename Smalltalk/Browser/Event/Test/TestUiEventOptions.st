CLASS TestUiEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := UiEventOptions new.
	self assert: [ options class = UiEventOptions ].
	self assert: [ options detail isNil ].
	self assert: [ options view isNil ].
	self assert: [ options bubbles isNil ].

	options detail: 3.
	self assert: [ options detail = 3 ].
	options view: Window default.
	self assert: [ options view = Window default ].

	options := UiEventOptions new detail: 1; view: Window default; cancelable: true; yourself.
	self assert: [ options detail = 1 ].
	self assert: [ options view = Window default ].
	self assert: [ options cancelable ].
!
