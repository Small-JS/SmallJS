CLASS QFont EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

"A font, used with QWidget setFont:. A size is either in points or in pixels:
 setting one makes the other -1."

CLASSMETHODS

new
	"Answer the default application font."
	^ self fromJs: INLINE 'new nodegui$.QFont()'.
!
family: family
	^ self fromJs: INLINE 'new nodegui$.QFont( family.js )'.
!
family: family pointSize: pointSize
	^ self fromJs: INLINE 'new nodegui$.QFont( family.js, pointSize.js )'.
!
fromVariant: variant
	"Answer the font held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QFont.fromQVariant( variant.js )'.
!

"Weight enums"

weightThin
	^ 100.
!
weightLight
	^ 300.
!
weightNormal
	^ 400.
!
weightMedium
	^ 500.
!
weightDemiBold
	^ 600.
!
weightBold
	^ 700.
!
weightBlack
	^ 900.
!

"Capitalization enums"

mixedCase
	"Normal text."
	^ 0.
!
allUppercase
	^ 1.
!
allLowercase
	^ 2.
!
smallCaps
	^ 3.
!
capitalize
	"The first character of each word is uppercase."
	^ 4.
!

"Stretch enums, in percent"

condensed
	^ 75.
!
unstretched
	^ 100.
!
expanded
	^ 125.
!

METHODS

"Family"

setFamily: family
	INLINE 'this.js.setFamily( family.js )'.
!
family
	^ String fromJs: INLINE 'this.js.family()'.
!
setStyleName: styleName
	"Use a style of the family, e.g. 'Light Italic'."
	INLINE 'this.js.setStyleName( styleName.js )'.
!

"Size"

setPointSize: pointSize
	INLINE 'this.js.setPointSize( pointSize.js )'.
!
pointSize
	"Answer -1 if the size is in pixels."
	^ Integer fromJs: INLINE 'this.js.pointSize()'.
!
setPixelSize: pixelSize
	INLINE 'this.js.setPixelSize( pixelSize.js )'.
!
pixelSize
	"Answer -1 if the size is in points."
	^ Integer fromJs: INLINE 'this.js.pixelSize()'.
!

"Style"

setBold: bold
	INLINE 'this.js.setBold( bold.js )'.
!
bold
	^ Boolean fromJs: INLINE 'this.js.bold()'.
!
setItalic: italic
	INLINE 'this.js.setItalic( italic.js )'.
!
italic
	^ Boolean fromJs: INLINE 'this.js.italic()'.
!
setWeight: weight
	"Use the weight enums. Weights of weightDemiBold and more are bold."
	INLINE 'this.js.setWeight( weight.js )'.
!
weight
	^ Integer fromJs: INLINE 'this.js.weight()'.
!
setCapitalization: capitalization
	"Use the capitalization enums."
	INLINE 'this.js.setCapitalization( capitalization.js )'.
!
capitalization
	^ Integer fromJs: INLINE 'this.js.capitalization()'.
!
setStretch: stretch
	"Use the stretch enums, or a percentage from 1 to 4000."
	INLINE 'this.js.setStretch( stretch.js )'.
!
stretch
	^ Integer fromJs: INLINE 'this.js.stretch()'.
!

"Printing"

toString
	"Answer a description of all properties, e.g. 'Arial,12,-1,5,700,0,0,0,0,0,1,0,0,0,100,1'."
	^ String fromJs: INLINE 'this.js.toString()'.
!
