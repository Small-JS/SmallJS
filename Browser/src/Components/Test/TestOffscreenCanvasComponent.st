CLASS TestOffscreenCanvasComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| component point pixel |
	component := MyBrowserApp default findComponent: OffscreenCanvasComponent.
	point := OffscreenCanvasComponent samplePoint.

	"Image drawn in main thread."
	pixel := ( component mainCanvas getContext2d getImageData: ( Rect origin: point extent: 1 @ 1 ) ) atPixel: 0 @ 0.
	self assert: [ pixel = #( 0 0 255 255 ) ].
	pixel := ( component mainCanvas getContext2d getImageData: ( Rect origin: 5 @ 5 extent: 1 @ 1 ) ) atPixel: 0 @ 0.
	self assert: [ pixel = #( 255 255 255 255 ) ].

	"Image drawn in worker, which replied with the pixel at the sample point."
	self assert: [ component workerPixel = #( 0 0 255 255 ) ].
!
