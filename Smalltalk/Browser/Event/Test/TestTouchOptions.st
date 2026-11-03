CLASS TestTouchOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options div |
	options := TouchOptions new.
	self assert: [ options class = TouchOptions ].
	self assert: [ options identifier isNil ].
	self assert: [ options target isNil ].
	self assert: [ options client isNil ].
	self assert: [ options page isNil ].
	self assert: [ options screen isNil ].
	self assert: [ options radius isNil ].

	"If only one coordinate is set, the other has the JS default value 0."
	INLINE 'options.js.clientY = 20; options.js.radiusX = 5'.
	self assert: [ options client = ( 0 @ 20 ) ].
	self assert: [ options radius = ( 5 @ 0 ) ].
	INLINE 'delete options.js.clientY; delete options.js.radiusX'.
	self assert: [ options client isNil ].
	self assert: [ options radius isNil ].

	div := Document new createElement: 'div'.
	options identifier: 1; target: div.
	self assert: [ options identifier = 1 ].
	self assert: [ options target = div ].
	self assert: [ options target class = HtmlDivElement ].

	options client: 10 @ 20; page: 30 @ 40; screen: 50 @ 60.
	self assert: [ options client = ( 10 @ 20 ) ].
	self assert: [ options page = ( 30 @ 40 ) ].
	self assert: [ options screen = ( 50 @ 60 ) ].

	options radius: 5 @ 6; rotationAngle: 45; force: 0.5.
	self assert: [ options radius = ( 5 @ 6 ) ].
	self assert: [ options rotationAngle = 45 ].
	self assert: [ options force = 0.5 ].
!
