CLASS TestTouch EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

disabled
	^ TouchEvent available not.
!
testNew
	| options div touch |
	self assertError: [ Touch new ].
	"Identifier and target are required, else this throws a JS TypeError."
	options := TouchOptions new.
	self assert: [ ( [ Touch options: options ] tryCatch: [ :error | error name ] ) = 'TypeError' ].

	div := Document new createElement: 'div'.
	options := TouchOptions new identifier: 7; target: div.
	touch := Touch options: options.
	self assert: [ touch class = Touch ].
	self assert: [ touch jsClassName = 'Touch' ].
	self assert: [ touch identifier = 7 ].
	self assert: [ touch target = div ].
	self assert: [ touch target class = HtmlDivElement ].
	self assert: [ touch client = ( 0 @ 0 ) ].
	self assert: [ touch force = 0 ].
!
testOptions
	| options touch |
	options := TouchOptions new
		identifier: 1; target: Window default;
		client: 10 @ 20; page: 30 @ 40; screen: 50 @ 60;
		radius: 5 @ 6; rotationAngle: 45; force: 0.5.
	touch := Touch options: options.
	self assert: [ touch target = Window default ].
	self assert: [ touch target class = Window ].
	self assert: [ touch client = ( 10 @ 20 ) ].
	self assert: [ touch page = ( 30 @ 40 ) ].
	self assert: [ touch screen = ( 50 @ 60 ) ].
	self assert: [ touch radius = ( 5 @ 6 ) ].
	self assert: [ touch rotationAngle = 45 ].
	self assert: [ touch force = 0.5 ].
!
