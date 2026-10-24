CLASS TestWheelEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testConstants
	self assert: [ WheelEvent deltaPixel = 0 ].
	self assert: [ WheelEvent deltaLine = 1 ].
	self assert: [ WheelEvent deltaPage = 2 ].
!
testNew
	| event |
	event := WheelEvent type: 'wheel'.
	self assert: [ event class = WheelEvent ].
	self assert: [ event type = 'wheel' ].
	self assert: [ event delta = ( 0 @ 0 @ 0 ) ].
	self assert: [ event deltaMode = WheelEvent deltaPixel ].
	"Inherited from MouseEvent"
	self assert: [ event client = ( 0 @ 0 ) ].
!
testOptions
	| event options |
	options := WheelEventOptions new
		delta: 1.5 @ -2 @ 3; deltaMode: WheelEvent deltaLine;
		clientX: 10; clientY: 20; ctrlKey: true; bubbles: true.
	event := WheelEvent type: 'wheel' options: options.
	self assert: [ event class = WheelEvent ].
	self assert: [ event delta = ( 1.5 @ -2 @ 3 ) ].
	self assert: [ event deltaMode = WheelEvent deltaLine ].
	"Inherited options"
	self assert: [ event client = ( 10 @ 20 ) ].
	self assert: [ event ctrlKey ].
	self assert: [ event bubbles ].
!
testListener
	| div options wheelEvent received |
	div := Document new createElement: 'div'.
	div addEventListener: 'wheel' then: [ :event | received := event ].
	options := WheelEventOptions new delta: 0 @ 100 @ 0.
	wheelEvent := WheelEvent type: 'wheel' options: options.
	div dispatchEvent: wheelEvent.
	self assert: [ received class = WheelEvent ].
	self assert: [ received delta y = 100 ].
!
