CLASS ImageBitmap EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

create: image then: block
	self fromJs: INLINE 'createImageBitmap( image.js )
		.then( ( imageBitmap ) => block.$value$( stImageBitmap$class.$fromJs$( imageBitmap ) ) )'.
!

METHODS

"Dimensions"

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
extent
	^ self width @ self height.
!

"Methods"

close
	INLINE 'this.js.close()'.
!
