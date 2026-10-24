CLASS TestWheelEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := WheelEventOptions new.
	self assert: [ options class = WheelEventOptions ].
	self assert: [ options delta isNil ].
	self assert: [ options deltaMode isNil ].

	options delta: 1 @ 2 @ 3.
	self assert: [ options delta = ( 1 @ 2 @ 3 ) ].
	options deltaMode: WheelEvent deltaPage.
	self assert: [ options deltaMode = WheelEvent deltaPage ].

	"If only some values are set, the others get the JS default value 0."
	options := WheelEventOptions new.
	INLINE 'options.js.deltaY = 5'.
	self assert: [ options delta = ( 0 @ 5 @ 0 ) ].

	"Inherited options"
	options clientX: 4; button: 1; detail: 2; cancelable: true.
	self assert: [ options clientX = 4 ].
	self assert: [ options button = 1 ].
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
