CLASS TestTouchEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

disabled
	^ TouchEvent available not.
!

"Helpers"

newTouch: identifier target: target
	| options |
	options := TouchOptions new identifier: identifier; target: target; client: 10 @ 20.
	^ Touch options: options.
!

"Tests"

testNew
	| event |
	event := TouchEvent type: 'touchstart'.
	self assert: [ event class = TouchEvent ].
	self assert: [ event type = 'touchstart' ].
	self assert: [ event touches isEmpty ].
	self assert: [ event targetTouches isEmpty ].
	self assert: [ event changedTouches isEmpty ].
	self assert: [ event altKey not ].
	self assert: [ event ctrlKey not ].
	self assert: [ event metaKey not ].
	self assert: [ event shiftKey not ].
!
testOptions
	| div touch1 touch2 options event |
	div := Document new createElement: 'div'.
	touch1 := self newTouch: 1 target: div.
	touch2 := self newTouch: 2 target: div.
	options := TouchEventOptions new
		touches: ( Array with: touch1 with: touch2 );
		targetTouches: ( Array with: touch1 );
		changedTouches: ( Array with: touch2 );
		altKey: true; ctrlKey: true; metaKey: false; shiftKey: true;
		detail: 1; bubbles: true.
	event := TouchEvent type: 'touchmove' options: options.
	self assert: [ event class = TouchEvent ].
	self assert: [ event type = 'touchmove' ].
	self assert: [ event touches = ( Array with: touch1 with: touch2 ) ].
	self assert: [ event touches first class = Touch ].
	self assert: [ event targetTouches = ( Array with: touch1 ) ].
	self assert: [ event changedTouches first identifier = 2 ].
	self assert: [ event altKey ].
	self assert: [ event ctrlKey ].
	self assert: [ event metaKey not ].
	self assert: [ event shiftKey ].
	"Inherited options"
	self assert: [ event detail = 1 ].
	self assert: [ event bubbles ].
!
testListener
	| div options received |
	div := Document new createElement: 'div'.
	div addEventListener: 'touchend' then: [ :event | received := event ].
	options := TouchEventOptions new changedTouches: ( Array with: ( self newTouch: 1 target: div ) ).
	div dispatchEvent: ( TouchEvent type: 'touchend' options: options ).
	self assert: [ received class = TouchEvent ].
	self assert: [ received changedTouches first target = div ].
!
