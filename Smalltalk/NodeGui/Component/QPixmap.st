CLASS QPixmap EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

"An image optimized for showing on screen, e.g. with QLabel setPixmap:.
 Use QImage to edit pixels, and convert it with fromImage:."

CLASSMETHODS

new
	"Answer an empty pixmap, with size 0 x 0."
	^ self fromJs: INLINE 'new nodegui$.QPixmap()'.
!
new: fileName
	"Answer an empty pixmap if the file cannot be read."
	^ self fromJs: INLINE 'new nodegui$.QPixmap( fileName.js )'.
!
fromImage: image
	^ self fromJs: INLINE 'nodegui$.QPixmap.fromImage( image.js, 0 )'.
!
fromVariant: variant
	"Answer the pixmap held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QPixmap.fromQVariant( variant.js )'.
!

"Transformation mode enums, used by scaled:mode:transformation:"

fastTransformation
	^ 0.
!
smoothTransformation
	^ 1.
!

METHODS

"Size"

width
	^ Integer fromJs: INLINE 'this.js.width()'.
!
height
	^ Integer fromJs: INLINE 'this.js.height()'.
!
size
	^ QSize width: self width height: self height.
!
isEmpty
	"Answer true if the pixmap has no pixels."
	^ self width = 0 | ( self height = 0 ).
!

"Files"

load: fileName
	"Answer true if the file was read. If not, the pixmap is empty."
	^ Boolean fromJs: INLINE 'this.js.load( fileName.js )'.
!
save: fileName
	"The format is taken from the file extension, e.g. '.png'. Answer true if the file was written."
	^ Boolean fromJs: INLINE 'this.js.save( fileName.js )'.
!

"Converting"

scaled: size mode: aspectRatioMode
	"Answer a new pixmap scaled smoothly to size, using a QSize aspect ratio mode enum."
	^ self scaled: size mode: aspectRatioMode transformation: QPixmap smoothTransformation.
!
scaled: size mode: aspectRatioMode transformation: transformationMode
	^ QPixmap fromJs: INLINE 'this.js.scaled( size.$width().js, size.$height().js, aspectRatioMode.js, transformationMode.js )'.
!
