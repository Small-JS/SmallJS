CLASS TestImageData EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| context imageData |
	context := ( Document default createElement: 'canvas' ) getContext2d.
	imageData := context getImageData: ( Rectangle origin: ( 20 @ 10 ) extent: ( 40 @ 30 ) ).
	self assert: [ imageData class = ImageData ].

	self assert: [ imageData data length = 4800 ].
	self assert: [ imageData width = 40 ].
	self assert: [ imageData height = 30 ].
	self assert: [ imageData extent = ( 40 @ 30 ) ].

	imageData := context createImageData: ( 20 @ 10 ).
	self assert: [ imageData class = ImageData ].

	self assert: [ imageData width = 20 ].
	self assert: [ imageData height = 10 ].
	self assert: [ imageData extent = ( 20 @ 10 ) ].

!
