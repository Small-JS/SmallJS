CLASS TestOffscreenCanvas EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| canvas |
	canvas := OffscreenCanvas new: 200 @ 100.
	self assert: [ canvas class = OffscreenCanvas ].

	self assert: [ canvas width = 200 ].
	canvas width: 120.
	self assert: [ canvas width = 120 ].

	self assert: [ canvas height = 100 ].
	canvas height: 60.
	self assert: [ canvas height = 60 ].

	self assert: [ canvas size = ( 120 @ 60 ) ].
	canvas size: ( 40 @ 30 ).
	self assert: [ canvas size = ( 40 @ 30 ) ].
!
testGetContext
	| canvas context |
	canvas := OffscreenCanvas new: 20 @ 10.
	context := canvas getContext: '2d'.
	self assert: [ context class = OffscreenCanvasRenderingContext2d ].
	self assert: [ context canvas = canvas ].

	context := canvas getContext2d.
	self assert: [ context class = OffscreenCanvasRenderingContext2d ].
	self assert: [ context isContextLost not ].
	self assertError: [ canvas getContext: 'unknown' ].
	context := canvas getContext: '2D'.
	self assert: [ context class = OffscreenCanvasRenderingContext2d ].
!
testDraw
	| canvas context |
	canvas := OffscreenCanvas new: 20 @ 10.
	context := canvas getContext2d.
	self assert: [ ( ( context getImageData: ( Rect origin: 5 @ 5 extent: 1 @ 1 ) ) atPixel: 0 @ 0 ) = #( 0 0 0 0 ) ].

	context fillStyle: 'blue'.
	context fillRect: ( Rect origin: 0 @ 0 extent: 10 @ 10 ).
	self assert: [ ( ( context getImageData: ( Rect origin: 5 @ 5 extent: 1 @ 1 ) ) atPixel: 0 @ 0 ) = #( 0 0 255 255 ) ].
	self assert: [ ( ( context getImageData: ( Rect origin: 15 @ 5 extent: 1 @ 1 ) ) atPixel: 0 @ 0 ) = #( 0 0 0 0 ) ].
!
testTransferToImageBitmap
	| canvas context imageBitmap |
	canvas := OffscreenCanvas new: 20 @ 10.
	context := canvas getContext2d.
	context fillStyle: 'blue'.
	context fillRect: ( Rect origin: 0 @ 0 extent: 20 @ 10 ).

	imageBitmap := canvas transferToImageBitmap.
	self assert: [ imageBitmap class = ImageBitmap ].
	self assert: [ imageBitmap extent = ( 20 @ 10 ) ].
	imageBitmap close.

	"After the transfer the canvas starts with a new blank image."
	self assert: [ ( ( context getImageData: ( Rect origin: 5 @ 5 extent: 1 @ 1 ) ) atPixel: 0 @ 0 ) = #( 0 0 0 0 ) ].
!
testTransferControlToOffscreen
	| element canvas |
	element := Document default createElement: 'canvas'.
	element size: 40 @ 30.
	canvas := element transferControlToOffscreen.
	self assert: [ canvas class = OffscreenCanvas ].
	self assert: [ canvas size = ( 40 @ 30 ) ].
	self assert: [ canvas getContext2d class = OffscreenCanvasRenderingContext2d ].
!
async testConvertToBlob
	| canvas context blob |
	canvas := OffscreenCanvas new: 20 @ 10.
	context := canvas getContext2d.
	context fillStyle: 'blue'.
	context fillRect: ( Rect origin: 0 @ 0 extent: 10 @ 10 ).

	blob := await canvas convertToBlob.
	self assert: [ blob class = Blob ].
	self assert: [ blob type = 'image/png' ].
	self assert: [ blob size > 0 ].

	blob := await canvas convertToBlobType: 'image/jpeg' quality: 0.8.
	self assert: [ blob type = 'image/jpeg' ].
	self assert: [ blob size > 0 ].
!
