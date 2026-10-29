CLASS QImage EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

"An image whose pixels can be read and changed. Coordinates start at 0, 0 in the top left corner.
 Convert it with QPixmap fromImage: to show it."

CLASSMETHODS

new
	"Answer an empty image."
	^ self fromJs: INLINE 'new nodegui$.QImage()'.
!
new: fileName
	"Answer an empty image if the file cannot be read."
	^ self fromJs: INLINE 'new nodegui$.QImage( fileName.js )'.
!
width: width height: height
	"Answer an image with format argb32. The pixels are not initialized, use fill:."
	^ self width: width height: height format: QImage argb32.
!
width: width height: height format: format
	"Use the format enums."
	^ self fromJs: INLINE 'new nodegui$.QImage( width.js, height.js, format.js )'.
!
fromVariant: variant
	"Answer the image held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QImage.fromQVariant( variant.js )'.
!

"Format enums"

invalid
	^ 0.
!
mono
	"1 bit per pixel."
	^ 1.
!
indexed8
	"8 bit indexes into a color table."
	^ 3.
!
rgb32
	"32 bit RGB, without alpha."
	^ 4.
!
argb32
	"32 bit RGB with alpha."
	^ 5.
!
rgb888
	"24 bit RGB."
	^ 13.
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
	^ QSize fromJs: INLINE 'this.js.size()'.
!
rect
	^ QRect fromJs: INLINE 'this.js.rect()'.
!
isEmpty
	"Answer true if the image has no pixels.
	 JS isNull(), not named isNull, which is used by JsObject to test for a JS null."
	^ Boolean fromJs: INLINE 'this.js.isNull()'.
!

"Format"

format
	"Answer a format enum."
	^ Integer fromJs: INLINE 'this.js.format()'.
!
depth
	"Answer the number of bits per pixel."
	^ Integer fromJs: INLINE 'this.js.depth()'.
!
hasAlphaChannel
	^ Boolean fromJs: INLINE 'this.js.hasAlphaChannel()'.
!
isGrayscale
	^ Boolean fromJs: INLINE 'this.js.isGrayscale()'.
!

"Pixels"

pixelColor: point
	^ QColor fromJs: INLINE 'this.js.pixelColor( point.$x().js, point.$y().js )'.
!
setPixelColor: color at: point
	INLINE 'this.js.setPixelColor( point.$x().js, point.$y().js, color.js )'.
!
fill: color
	"Set all pixels to color."
	INLINE 'this.js.fill( color.js )'.
!
invertPixels
	"Invert the RGB values of all pixels, e.g. black becomes white."
	INLINE 'this.js.invertPixels()'.
!

"Converting"

copy: rect
	"Answer a new image of the part rect."
	^ QImage fromJs: INLINE 'this.js.copy( rect.js )'.
!
scaled: size mode: aspectRatioMode
	"Answer a new image scaled smoothly to size, using a QSize aspect ratio mode enum."
	^ QImage fromJs: INLINE 'this.js.scaled( size.$width().js, size.$height().js, aspectRatioMode.js, 1 )'.
!
scaledToWidth: width
	"Answer a new image scaled smoothly to width, keeping the aspect ratio."
	^ QImage fromJs: INLINE 'this.js.scaledToWidth( width.js, 1 )'.
!
scaledToHeight: height
	^ QImage fromJs: INLINE 'this.js.scaledToHeight( height.js, 1 )'.
!
mirroredHorizontal: horizontal vertical: vertical
	"Answer a new image mirrored left to right if horizontal, top to bottom if vertical."
	^ QImage fromJs: INLINE 'this.js.mirrored( horizontal.js, vertical.js )'.
!

"Files"

load: fileName
	"Answer true if the file was read. If not, the image is empty."
	^ Boolean fromJs: INLINE 'this.js.load( fileName.js )'.
!
save: fileName
	"The format is taken from the file extension, e.g. '.png'. Answer true if the file was written."
	^ Boolean fromJs: INLINE 'this.js.save( fileName.js )'.
!
