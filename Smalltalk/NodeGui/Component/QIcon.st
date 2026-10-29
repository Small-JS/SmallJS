CLASS QIcon EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

"An icon, that can hold images for several sizes, modes and states.
 Qt picks the best image when the icon is shown, e.g. in a button or window title."

CLASSMETHODS

new
	"Answer an empty icon."
	^ self fromJs: INLINE 'new nodegui$.QIcon()'.
!
new: fileName
	^ self fromJs: INLINE 'new nodegui$.QIcon( fileName.js )'.
!
fromPixmap: pixmap
	^ self fromJs: INLINE 'new nodegui$.QIcon( pixmap.js )'.
!
fromVariant: variant
	"Answer the icon held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QIcon.fromQVariant( variant.js )'.
!

"Mode enums"

normal
	^ 0.
!
disabled
	^ 1.
!
active
	^ 2.
!
selected
	^ 3.
!

"State enums"

off
	^ 0.
!
on
	"E.g. for a checked button."
	^ 1.
!

METHODS

name
	"Answer the name of a theme icon, or an empty string."
	^ String fromJs: INLINE 'this.js.name()'.
!
isEmpty
	"Answer true if the icon has no images.
	 JS isNull(), not named isNull, which is used by JsObject to test for a JS null."
	^ Boolean fromJs: INLINE 'this.js.isNull()'.
!

"Images"

addFile: fileName
	"Add the image in fileName, for its own size."
	INLINE 'this.js.addFile( fileName.js )'.
!
addFile: fileName size: size
	"Add the image in fileName, for size."
	INLINE 'this.js.addFile( fileName.js, size.js )'.
!
addPixmap: pixmap
	INLINE 'this.js.addPixmap( pixmap.js )'.
!
addPixmap: pixmap mode: mode state: state
	"Use the mode and state enums."
	INLINE 'this.js.addPixmap( pixmap.js, mode.js, state.js )'.
!
availableSizes
	"Answer the sizes of the images added for a size. An icon read from a file has none."
	^ Array fromJs: INLINE 'this.js.availableSizes()' elementClass: QSize.
!

"Rendering"

pixmap: size
	"Answer a pixmap of size, or smaller to keep the aspect ratio."
	^ QPixmap fromJs: INLINE 'this.js.pixmap( size.$width().js, size.$height().js )'.
!
pixmap: size mode: mode state: state
	^ QPixmap fromJs: INLINE 'this.js.pixmap( size.$width().js, size.$height().js, mode.js, state.js )'.
!
actualSize: size
	"Answer the size of the pixmap for size.
	 JS actualSize() does not unwrap its argument, so call the native object."
	^ QSize fromJs: INLINE 'new nodegui$.QSize( this.js.native.actualSize( size.js.native, 0, 0 ) )'.
!
