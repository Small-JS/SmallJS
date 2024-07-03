CLASS HtmlCanvasElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

"Properties"

height
	^ Integer fromJs: INLINE 'this.js.height'.
!
height: height
	^ INLINE 'this.js.height = height.js'.
!
width
	^ Integer fromJs: INLINE 'this.js.width'.
!
width: width
	^ INLINE 'this.js.width = width.js'.
!
size
	^ self width @ self height.
!
size: size
	self width: size x.
	self height: size y.
!

"Methods"

captureStream
	^ MediaStream fromJs: INLINE 'this.js.captureStream()'.
!
captureStream: frameRate
	^ MediaStream fromJs: INLINE 'this.js.captureStream( frameRate.js )'.
!
getContext: type
	| context |
	context := JsObject fromJs: INLINE 'this.js.getContext( type.js )'.

	type := type toLowerCase.
	type = '2d' ifTrue: [ ^ CanvasRenderingContext2d fromJs: context js ].

	self error: [ 'Unsupported or invalid canvas context', context jsClassName ].
!
toBlobType: type quality: quality then: block
	INLINE 'this.js.toBlob( ( blob ) => block.$value$( stBlob$class.$fromJs$( blob ) ), type.js, quality.js )'.
!
toDataUrlQuality: quality
	^ String fromJs: INLINE 'this.js.toDataUrl( quality.js )'.
!
transferControlToOffscreen
	^ OffscreenCanvas fromJs: INLINE 'this.js.transferControlToOffscreen()'.
!