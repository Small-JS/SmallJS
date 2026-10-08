CLASS TestPointerEventOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := PointerEventOptions new.
	self assert: [ options class = PointerEventOptions ].
	self assert: [ options pointerId isNil ].
	self assert: [ options pointerType isNil ].
	self assert: [ options pressure isNil ].
	self assert: [ options contact isNil ].
	self assert: [ options tilt isNil ].

	options pointerId: 3; pointerType: 'touch'; isPrimary: true.
	self assert: [ options pointerId = 3 ].
	self assert: [ options pointerType = 'touch' ].
	self assert: [ options isPrimary ].

	options contact: 1.5 @ 2.5.
	self assert: [ options contact = ( 1.5 @ 2.5 ) ].

	options pressure: 0.75; tangentialPressure: 0.5.
	self assert: [ options pressure = 0.75 ].
	self assert: [ options tangentialPressure = 0.5 ].

	options tilt: 10 @ 20; twist: 30; altitudeAngle: 1.25; azimuthAngle: 3.5.
	self assert: [ options tilt = ( 10 @ 20 ) ].
	self assert: [ options twist = 30 ].
	self assert: [ options altitudeAngle = 1.25 ].
	self assert: [ options azimuthAngle = 3.5 ].

	"Inherited options"
	options button: 1; detail: 2; cancelable: true.
	self assert: [ options button = 1 ].
	self assert: [ options detail = 2 ].
	self assert: [ options cancelable ].
!
