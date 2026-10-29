CLASS TestQIcon EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| icon |
	icon := QIcon new: 'missing.ico'.
	self assert: [ icon name = '' ].
	self assert: [ icon isEmpty ].
	self assert: [ QIcon new isEmpty ].

	icon := QIcon new: 'assets/logo.png'.
	self assert: [ icon jsClassName = 'QIcon' ].
	self assert: [ icon isEmpty not ].
	"An icon read from a file has no sizes."
	self assert: [ icon availableSizes isEmpty ].
!
testImages
	| icon sizes |
	icon := QIcon new.
	icon addFile: 'assets/logo.png' size: ( QSize width: 16 height: 16 ).
	icon addPixmap: ( QPixmap new: 'assets/logo.png' ).
	self assert: [ icon isEmpty not ].
	sizes := icon availableSizes.
	self assert: [ sizes length = 2 ].
	self assert: [ sizes includes: ( QSize width: 16 height: 16 ) ].
	self assert: [ sizes includes: ( QSize width: 153 height: 167 ) ].

	icon addPixmap: ( QPixmap new: 'assets/logo.png' ) mode: QIcon disabled state: QIcon on.
	icon addFile: 'assets/logo.ico'.
!
testRendering
	| icon pixmap |
	icon := QIcon fromPixmap: ( QPixmap new: 'assets/logo.png' ).
	self assert: [ icon isEmpty not ].
	"The pixmap keeps the aspect ratio."
	pixmap := icon pixmap: ( QSize width: 32 height: 32 ).
	self assert: [ pixmap height = 32 ].
	self assert: [ pixmap width < 32 ].
	self assert: [ ( icon actualSize: ( QSize width: 32 height: 32 ) ) = pixmap size ].
	pixmap := icon pixmap: ( QSize width: 32 height: 32 ) mode: QIcon disabled state: QIcon off.
	self assert: [ pixmap height = 32 ].
!
testFromVariant
	| button |
	button := QPushButton new.
	button setProperty: 'icon' value: ( QIcon new: 'assets/logo.png' ).
	self assert: [ ( QIcon fromVariant: ( button property: 'icon' ) ) isEmpty not ].
!
