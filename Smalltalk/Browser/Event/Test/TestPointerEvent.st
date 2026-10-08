CLASS TestPointerEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event id |
	event := PointerEvent type: 'pointerdown'.
	self assert: [ event class = PointerEvent ].
	self assert: [ event type = 'pointerdown' ].
	self assert: [ event pointerId = 0 ].
	self assert: [ event pointerType = '' ].
	self assert: [ event isPrimary not ].
	self assert: [ event contact = ( 1 @ 1 ) ].
	self assert: [ event pressure = 0 ].
	self assert: [ event tangentialPressure = 0 ].
	self assert: [ event tilt = ( 0 @ 0 ) ].
	self assert: [ event twist = 0 ].
	self assert: [ ( event altitudeAngle - ( Float pi / 2 ) ) abs < 0.001 ].
	self assert: [ event azimuthAngle = 0 ].
	"Not supported by all browsers yet."
	id := event persistentDeviceId.
	self assert: [ id isNil or: [ id = 0 ] ].
	self assert: [ event coalescedEvents isEmpty ].
	self assert: [ event predictedEvents isEmpty ].
!
testOptions
	| event options |
	options := PointerEventOptions new
		pointerId: 7; pointerType: 'pen'; isPrimary: true;
		contact: 10 @ 20;
		pressure: 0.5; tangentialPressure: -0.25;
		tilt: 30 @ -45; twist: 90;
		clientX: 5; ctrlKey: true; bubbles: true;
		yourself.
	event := PointerEvent type: 'pointermove' options: options.
	self assert: [ event class = PointerEvent ].
	self assert: [ event type = 'pointermove' ].
	self assert: [ event pointerId = 7 ].
	self assert: [ event pointerType = 'pen' ].
	self assert: [ event isPrimary ].
	self assert: [ event contact = ( 10 @ 20 ) ].
	self assert: [ event pressure = 0.5 ].
	self assert: [ event tangentialPressure = -0.25 ].
	self assert: [ event tilt = ( 30 @ -45 ) ].
	self assert: [ event twist = 90 ].
	"Inherited options"
	self assert: [ event client x = 5 ].
	self assert: [ event ctrlKey ].
	self assert: [ event bubbles ].

	"Altitude and azimuth can be set instead of tilt."
	options := PointerEventOptions new altitudeAngle: 1; azimuthAngle: 2; yourself.
	event := PointerEvent type: 'pointermove' options: options.
	self assert: [ ( event altitudeAngle - 1 ) abs < 0.001 ].
	self assert: [ ( event azimuthAngle - 2 ) abs < 0.001 ].
!
testFromJsSubEvent
	| event |

	event := UiEvent fromJsSubEvent: INLINE 'new MouseEvent( "click" )'.
	self assert: [ event class = MouseEvent ].
	self assert: [ event type = 'click' ].

	event := UiEvent fromJsSubEvent: INLINE 'new PointerEvent( "pointerdown" )'.
	self assert: [ event class = PointerEvent ].
	self assert: [ event type = 'pointerdown' ].
!
