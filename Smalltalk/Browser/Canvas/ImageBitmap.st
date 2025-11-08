CLASS ImageBitmap EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

async create: image
	^ self fromJs: INLINE 'await createImageBitmap( image.js )'.
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
