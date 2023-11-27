CLASS HtmlImageElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS class HTMLImageElement,
	 of which variable js contains an instance."

imageWidth: width height: height
	^ HtmlImageElement fromJs: INLINE 'HtmlImageElement.Image( width, height )'.
!

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

"Position"

x
	^ Integer fromJs: INLINE 'this.js.x'.
!
x: x
	INLINE 'this.js.x = x.js'.
!
y
	^ Integer fromJs: INLINE 'this.js.y'.
!
y: y
	INLINE 'this.js.y = y.js'.
!
position
	self x @ self y.
!
position: point
	self x: point x y: point y.
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
