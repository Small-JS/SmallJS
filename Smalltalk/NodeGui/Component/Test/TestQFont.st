CLASS TestQFont EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| font |
	font := QFont family: 'Arial' pointSize: 12.
	self assert: [ font jsClassName = 'QFont' ].
	self assert: [ font family = 'Arial' ].
	self assert: [ font pointSize = 12 ].
	self assert: [ font pixelSize = -1 ].

	font setFamily: 'Courier New'.
	self assert: [ font family = 'Courier New' ].
	font setStyleName: 'Bold'.
	self assert: [ ( QFont family: 'Arial' ) family = 'Arial' ].
	self assert: [ QFont new family isEmpty not ].
!
testSize
	"Setting a size in pixels makes the point size -1, and the other way around."
	| font |
	font := QFont new.
	font setPixelSize: 20.
	self assert: [ font pixelSize = 20 ].
	self assert: [ font pointSize = -1 ].
	font setPointSize: 14.
	self assert: [ font pointSize = 14 ].
	self assert: [ font pixelSize = -1 ].
!
testStyle
	| font |
	font := QFont family: 'Arial' pointSize: 12.
	self assert: [ font bold not ].
	self assert: [ font weight = QFont weightNormal ].
	font setBold: true.
	self assert: [ font bold ].
	self assert: [ font weight = QFont weightBold ].
	font setWeight: QFont weightLight.
	self assert: [ font bold not ].

	self assert: [ font italic not ].
	font setItalic: true.
	self assert: [ font italic ].

	self assert: [ font capitalization = QFont mixedCase ].
	font setCapitalization: QFont smallCaps.
	self assert: [ font capitalization = QFont smallCaps ].

	font setStretch: QFont condensed.
	self assert: [ font stretch = QFont condensed ].
!
testToString
	self assert: [ ( QFont family: 'Arial' pointSize: 12 ) toString startsWith: 'Arial,12,-1,' ].
!
testWidget
	| label font |
	label := QLabel new.
	font := QFont family: 'Arial' pointSize: 14.
	label setFont: font.
	self assert: [ label font family = 'Arial' ].
	self assert: [ label font pointSize = 14 ].
!
testFromVariant
	| label |
	label := QLabel new.
	label setFont: ( QFont family: 'Arial' pointSize: 14 ).
	self assert: [ ( QFont fromVariant: ( label property: 'font' ) ) pointSize = 14 ].
!
