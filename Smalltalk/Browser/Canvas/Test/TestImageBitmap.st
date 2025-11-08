CLASS TestImageBitmap EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

async test
	| context imageData imageBitmap |
	context := ( Document default createElement: 'canvas' ) getContext2d.
	imageData := context getImageData: ( Rect origin: ( 20 @ 10 ) extent: ( 40 @ 30 ) ).
	self assert: [ imageData class = ImageData ].

	imageBitmap := await ImageBitmap create: imageData.
	self assert: [ imageBitmap class = ImageBitmap ].

	self assert: [ imageBitmap width = 40 ].
	self assert: [ imageBitmap height = 30 ].
	self assert: [ imageBitmap extent = ( 40 @ 30 ) ].

	imageBitmap close.
!
