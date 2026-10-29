CLASS TestQImage EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| image |
	image := QImage new.
	self assert: [ image jsClassName = 'QImage' ].
	self assert: [ image isEmpty ].
	self assert: [ image format = QImage invalid ].
	self assert: [ ( QImage new: 'missing.png' ) isEmpty ].

	image := QImage width: 4 height: 3.
	self assert: [ image isEmpty not ].
	self assert: [ image width = 4 ].
	self assert: [ image height = 3 ].
	self assert: [ image size = ( QSize width: 4 height: 3 ) ].
	self assert: [ image rect = ( QRect left: 0 top: 0 width: 4 height: 3 ) ].
	self assert: [ image format = QImage argb32 ].
	self assert: [ image depth = 32 ].
	self assert: [ image hasAlphaChannel ].

	image := QImage width: 4 height: 3 format: QImage rgb32.
	self assert: [ image format = QImage rgb32 ].
	self assert: [ image hasAlphaChannel not ].
	self assert: [ ( QImage new: 'assets/logo.png' ) width = 153 ].
!
testPixels
	| image red blue |
	red := QColor red: 255 green: 0 blue: 0.
	blue := QColor red: 0 green: 0 blue: 255.
	image := QImage width: 4 height: 3.
	image fill: red.
	image setPixelColor: blue at: ( QPoint x: 1 y: 2 ).
	self assert: [ ( image pixelColor: ( QPoint x: 1 y: 2 ) ) = blue ].
	self assert: [ ( image pixelColor: ( QPoint x: 0 y: 0 ) ) = red ].
	self assert: [ image isGrayscale not ].

	image invertPixels.
	self assert: [ ( image pixelColor: ( QPoint x: 0 y: 0 ) ) = ( QColor red: 0 green: 255 blue: 255 ) ].

	image fill: ( QColor red: 128 green: 128 blue: 128 ).
	self assert: [ image isGrayscale ].
!
testConverting
	| image white mirrored part |
	white := QColor red: 255 green: 255 blue: 255.
	image := QImage width: 4 height: 3.
	image fill: ( QColor red: 0 green: 0 blue: 0 ).
	image setPixelColor: white at: ( QPoint x: 0 y: 0 ).

	mirrored := image mirroredHorizontal: true vertical: false.
	self assert: [ ( mirrored pixelColor: ( QPoint x: 3 y: 0 ) ) = white ].
	mirrored := image mirroredHorizontal: false vertical: true.
	self assert: [ ( mirrored pixelColor: ( QPoint x: 0 y: 2 ) ) = white ].

	part := image copy: ( QRect left: 0 top: 0 width: 2 height: 2 ).
	self assert: [ part size = ( QSize width: 2 height: 2 ) ].
	self assert: [ ( part pixelColor: ( QPoint x: 0 y: 0 ) ) = white ].

	self assert: [ ( image scaled: ( QSize width: 8 height: 8 ) mode: QSize keepAspectRatio ) size = ( QSize width: 8 height: 6 ) ].
	self assert: [ ( image scaledToWidth: 8 ) size = ( QSize width: 8 height: 6 ) ].
	self assert: [ ( image scaledToHeight: 6 ) size = ( QSize width: 8 height: 6 ) ].
	"The receiver is not changed."
	self assert: [ image size = ( QSize width: 4 height: 3 ) ].
!
testFiles
	| image fileName loaded |
	image := QImage width: 4 height: 3.
	image fill: ( QColor red: 0 green: 128 blue: 255 ).
	fileName := Path join: Os tmpDir with: 'smalljs-test-qimage.png'.
	self assert: [ image save: fileName ].

	loaded := QImage new.
	self assert: [ loaded load: fileName ].
	self assert: [ loaded size = image size ].
	self assert: [ ( loaded pixelColor: ( QPoint x: 0 y: 0 ) ) = ( QColor red: 0 green: 128 blue: 255 ) ].
	self assert: [ ( loaded load: 'missing.png' ) not ].
	Fs unlinkSync: fileName.
!
