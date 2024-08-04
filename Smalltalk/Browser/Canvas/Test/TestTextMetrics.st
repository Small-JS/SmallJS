CLASS TestTextMetrics EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| context textMetrics |
	context := ( Document default createElement: 'canvas' ) getContext2d.
	textMetrics := context measureText: 'Hello world'.
	self assert: [ textMetrics class = TextMetrics ].

	self assert: [ textMetrics width > 40 ].

	self assert: [ textMetrics actualBoundingBoxLeft <= 0 ].
	self assert: [ textMetrics actualBoundingBoxRight >= 40 ].
	self assert: [ textMetrics actualBoundingBoxAscent >= 5 ].
	self assert: [ textMetrics actualBoundingBoxDescent >= 0 ].

	self assert: [ textMetrics fontBoundingBoxAscent >= 5 ].
	self assert: [ textMetrics fontBoundingBoxDescent >= 0 ].

	self assert: [ textMetrics hangingBaseline >= 5 ].
	self assert: [ textMetrics alphabeticBaseline = 0 ].
	self assert: [ textMetrics ideographicBaseline < -0.5 ].
!
