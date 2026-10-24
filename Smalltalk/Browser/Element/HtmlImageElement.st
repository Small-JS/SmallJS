CLASS HtmlImageElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLImageElement."

CLASSMETHODS

width: width height: height
	"Create a new image element, not yet connected to a document."
	^ self fromJs: INLINE 'new Image( width.js, height.js )'.
!

METHODS

"Dimensions"

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
width: width
	INLINE 'this.js.width  = width.js'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
height: height
	INLINE 'this.js.height  = height.js'.
!
size
	^ self width @ self height.
!
size: size
	self width: size x; height: size y.
!
sizes
	^ String fromJs: INLINE 'this.js.sizes'.
!
naturalWidth
	^ Integer fromJs: INLINE 'this.js.naturalWidth'.
!
naturalHeight
	^ Integer fromJs: INLINE 'this.js.naturalHeight'.
!
naturalSize
	^ self naturalWidth @ self naturalHeight.
!

"Position, read-only"

x
	^ Integer fromJs: INLINE 'this.js.x'.
!
y
	^ Integer fromJs: INLINE 'this.js.y'.
!
position
	^ self x @ self y.
!

"Other properties"

alt
	^ String fromJs: INLINE 'this.js.alt'.
!
alt: alt
	INLINE 'this.js.alt = alt.js'.
!
complete
	^ Boolean fromJs: INLINE 'this.js.complete'.
!
crossOrigin
	^ String fromJs: INLINE 'this.js.crossOrigin'.
!
crossOrigin: crossOrigin
	INLINE 'this.js.crossOrigin  = crossOrigin.js'.
!
currentSrc
	^ String fromJs: INLINE 'this.js.currentSrc'.
!
decoding
	^ String fromJs: INLINE 'this.js.decoding'.
!
decoding: decoding
	INLINE 'this.js.decoding  = decoding.js'.
!
isMap
	^ Boolean fromJs: INLINE 'this.js.isMap'.
!
isMap: isMap
	INLINE 'this.js.isMap  = isMap.js'.
!
loading
	^ String fromJs: INLINE 'this.js.loading'.
!
loading: loading
	INLINE 'this.js.loading  = loading.js'.
!
src
	^ String fromJs: INLINE 'this.js.src'.
!
src: src
	INLINE 'this.js.src  = src.js'.
!
srcSet
	^ String fromJs: INLINE 'this.js.srcset'.
!
srcSet: srcSet
	INLINE 'this.js.srcset = srcSet.js'.
!
useMap
	^ String fromJs: INLINE 'this.js.useMap'.
!
useMap: useMap
	INLINE 'this.js.useMap  = useMap.js'.
!

"Methods"

decodeThen: thenBlock catch: catchBlock
	Error.  "Force import of class."
	INLINE 'this.js.decode()
		.then( () => { thenBlock.js() } )
		.catch( ( error ) => { catchBlock.js( stError$class.$fromJs$( error ) ) } )'.
!
