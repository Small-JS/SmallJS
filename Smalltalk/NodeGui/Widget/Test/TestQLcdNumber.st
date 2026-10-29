CLASS TestQLcdNumber EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| lcd |
	lcd := QLcdNumber new.
	self assert: [ lcd jsClassName = 'QLCDNumber' ].
	self assert: [ lcd value = 0 ].

	lcd display: 42.
	self assert: [ lcd value = 42 ].
	self assert: [ lcd intValue = 42 ].
	lcd display: 1.5.
	self assert: [ lcd value = 1.5 ].
	self assert: [ lcd intValue = 2 ].
	lcd display: '12:30'.
	self assert: [ lcd value = 0 ].
!
testOverflow
	| lcd count |
	lcd := QLcdNumber new.
	count := 0.
	lcd onOverflow: [ count := count + 1 ].
	self assert: [ lcd digitCount = 5 ].
	self assert: [ ( lcd checkOverflow: 99999 ) not ].
	self assert: [ lcd checkOverflow: 100000 ].

	lcd display: 100000.
	self assert: [ count = 1 ].
	lcd setDigitCount: 6.
	self assert: [ lcd digitCount = 6 ].
	self assert: [ ( lcd checkOverflow: 100000 ) not ].
!
testAppearance
	| lcd |
	lcd := QLcdNumber new.
	self assert: [ lcd mode = QLcdNumber dec ].
	lcd setMode: QLcdNumber hex.
	self assert: [ lcd mode = QLcdNumber hex ].
	lcd display: 255.
	self assert: [ lcd intValue = 255 ].

	self assert: [ lcd segmentStyle = QLcdNumber filled ].
	lcd setSegmentStyle: QLcdNumber flat.
	self assert: [ lcd segmentStyle = QLcdNumber flat ].

	self assert: [ lcd smallDecimalPoint not ].
	lcd setSmallDecimalPoint: true.
	self assert: [ lcd smallDecimalPoint ].
!
