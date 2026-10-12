CLASS OffscreenCanvas EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: OffscreenCanvas.
	 It can be used in the main thread and in workers.
	 Create one with: OffscreenCanvas new: size,
	 or get one from: HtmlCanvasElement transferControlToOffscreen.
	 An OffscreenCanvas can be transferred to a worker with: Worker postMessage: transfer: ."

CLASSMETHODS

new: size
	"Size is a Point: width @ height."
	^ self fromJs: INLINE 'new OffscreenCanvas( size.x.js, size.y.js )'.
!

METHODS

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
	| context |
	context := JsObject fromJs: INLINE 'this.js.getContext( type.js )'.

	type := type toLowerCase.
	type = '2d' ifTrue: [ ^ OffscreenCanvasRenderingContext2d fromJs: context js ].

	self error: 'Unsupported or invalid offscreen canvas context: ', type.
!
getContext2d
	^ OffscreenCanvasRenderingContext2d fromJs: INLINE 'this.js.getContext( "2d" )'.
!
async convertToBlob
	"Return a PNG Blob of the image."
	Blob.	"Force import"
	^ Blob fromJs: INLINE 'await this.js.convertToBlob()'.
!
async convertToBlobType: type quality: quality
	"Return a Blob of the image with the given MIME type.
	 Quality is between 0.0 and 1.0, for lossy types like 'image/jpeg' and 'image/webp'."
	Blob.	"Force import"
	^ Blob fromJs: INLINE 'await this.js.convertToBlob( { type: type.js, quality: quality.js } )'.
!
transferToImageBitmap
	"Return an ImageBitmap of the current image, and start a new blank image."
	^ ImageBitmap fromJs: INLINE 'this.js.transferToImageBitmap()'.
!

"Events"

onContextLost: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJsSubEvent: jsEvent ) ].
	INLINE 'this.js.oncontextlost = jsBlock.js'.
!
onContextRestored: block
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJsSubEvent: jsEvent ) ].
	INLINE 'this.js.oncontextrestored = jsBlock.js'.
!
