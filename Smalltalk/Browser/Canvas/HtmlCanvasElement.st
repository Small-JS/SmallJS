CLASS HtmlCanvasElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

"Properties"

height
	^ Integer fromJs: INLINE 'this.js.height'.
!
height: height
	INLINE 'this.js.height = height.js'.
!
width
	^ Integer fromJs: INLINE 'this.js.width'.
!
width: width
	INLINE 'this.js.width = width.js'.
!
size
	^ self width @ self height.
!
size: size
	self width: size x.
	self height: size y.
!

"Methods"

getContext: type
	type toLowerCase = '2d' ifTrue: [ ^ self getContext2d ].

	self error: 'Unsupported or invalid canvas context: ', type.
!
getContext2d
	^ CanvasRenderingContext2d fromJs: INLINE 'this.js.getContext( "2d" )'.
!
toBlobType: type quality: quality then: block
	Blob.	"Force import"
	INLINE 'this.js.toBlob( ( blob ) => block.$value$( stBlob$class.$fromJs$( blob ) ), type.js, quality.js )'.
!
toDataUrlType: type quality: quality
	^ String fromJs: INLINE 'this.js.toDataURL( type.js, quality.js )'.
!
transferControlToOffscreen
	^ OffscreenCanvas fromJs: INLINE 'this.js.transferControlToOffscreen()'.
!
