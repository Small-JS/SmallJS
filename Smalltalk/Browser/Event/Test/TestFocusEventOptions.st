CLASS TestFocusEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options div |
	options := FocusEventOptions new.
	self assert: [ options class = FocusEventOptions ].
	self assert: [ options relatedTarget isNil ].

	div := Document new createElement: 'div'.
	options relatedTarget: div.
	self assert: [ options relatedTarget = div ].
	self assert: [ options relatedTarget class = HtmlDivElement ].

	options relatedTarget: Window default.
	self assert: [ options relatedTarget class = Window ].

	"Inherited options"
	options detail: 2; cancelable: true.
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
