CLASS TestQPixmap EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| pixmap |
	pixmap := QPixmap new: 'missing.png'.
	self assert: [ pixmap class = QPixmap ].
	self assert: [ pixmap isEmpty ].

	pixmap := QPixmap new.
	self assert: [ pixmap isEmpty ].
	self assert: [ pixmap size = ( QSize width: 0 height: 0 ) ].

	pixmap := QPixmap new: 'assets/logo.png'.
	self assert: [ pixmap isEmpty not ].
	self assert: [ pixmap width = 153 ].
	self assert: [ pixmap height = 167 ].
	self assert: [ pixmap size = ( QSize width: 153 height: 167 ) ].
!
testFiles
	| pixmap fileName |
	pixmap := QPixmap new.
	self assert: [ pixmap load: 'assets/logo.png' ].
	self assert: [ pixmap width = 153 ].

	fileName := Path join: Os tmpDir with: 'smalljs-test-qpixmap.png'.
	self assert: [ pixmap save: fileName ].
	self assert: [ ( QPixmap new: fileName ) size = pixmap size ].
	Fs unlinkSync: fileName.

	"Loading a missing file empties the pixmap."
	self assert: [ ( pixmap load: 'missing.png' ) not ].
	self assert: [ pixmap isEmpty ].
!
testScaled
	| pixmap scaled |
	pixmap := QPixmap new: 'assets/logo.png'.
	scaled := pixmap scaled: ( QSize width: 50 height: 50 ) mode: QSize keepAspectRatio.
	self assert: [ scaled size = ( QSize width: 45 height: 50 ) ].
	scaled := pixmap scaled: ( QSize width: 50 height: 50 ) mode: QSize ignoreAspectRatio
		transformation: QPixmap fastTransformation.
	self assert: [ scaled size = ( QSize width: 50 height: 50 ) ].
	"The receiver is not changed."
	self assert: [ pixmap width = 153 ].
!
testFromImage
	| pixmap |
	pixmap := QPixmap fromImage: ( QImage width: 4 height: 3 ).
	self assert: [ pixmap size = ( QSize width: 4 height: 3 ) ].
!
