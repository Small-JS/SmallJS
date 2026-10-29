CLASS QColor EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

"A color, with red, green, blue and alpha (opacity) components from 0 to 255."

CLASSMETHODS

new
	"Answer an invalid color."
	^ self fromJs: INLINE 'new nodegui$.QColor()'.
!
red: red green: green blue: blue
	^ self red: red green: green blue: blue alpha: 255.
!
red: red green: green blue: blue alpha: alpha
	^ self fromJs: INLINE 'new nodegui$.QColor( red.js, green.js, blue.js, alpha.js )'.
!
named: name
	"Name is an SVG color name, e.g. 'red', or a hex value, e.g. '#ff8000'."
	^ self fromJs: INLINE 'new nodegui$.QColor( name.js )'.
!
hue: hue saturation: saturation value: value
	"Hue from 0 to 359, saturation and value from 0 to 255."
	^ self fromJs: INLINE 'nodegui$.QColor.fromHsv( hue.js, saturation.js, value.js )'.
!
hue: hue saturation: saturation lightness: lightness
	"Hue from 0 to 359, saturation and lightness from 0 to 255."
	^ self fromJs: INLINE 'nodegui$.QColor.fromHsl( hue.js, saturation.js, lightness.js )'.
!
fromVariant: variant
	"Answer the color held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QColor.fromQVariant( variant.js )'.
!

METHODS

"Comparing"

= color
	"Colors are equal if their components are equal."
	^ ( color isKindOf: QColor ) and: [ self rgba = color rgba ].
!

"Components"

red
	^ Integer fromJs: INLINE 'this.js.red()'.
!
setRed: red
	INLINE 'this.js.setRed( red.js )'.
!
green
	^ Integer fromJs: INLINE 'this.js.green()'.
!
setGreen: green
	INLINE 'this.js.setGreen( green.js )'.
!
blue
	^ Integer fromJs: INLINE 'this.js.blue()'.
!
setBlue: blue
	INLINE 'this.js.setBlue( blue.js )'.
!
alpha
	"Answer 0 for transparent, 255 for opaque."
	^ Integer fromJs: INLINE 'this.js.alpha()'.
!
setAlpha: alpha
	INLINE 'this.js.setAlpha( alpha.js )'.
!
rgb
	"Answer the color as an integer 0xAARRGGBB, with alpha 255."
	^ Integer fromJs: INLINE 'this.js.rgb()'.
!
rgba
	"Answer the color as an integer 0xAARRGGBB."
	^ Integer fromJs: INLINE 'this.js.rgba()'.
!

"Printing"

name
	"Answer the color as hex string '#rrggbb', e.g. for a style sheet."
	^ String fromJs: INLINE '"#" + [ this.js.red(), this.js.green(), this.js.blue() ]
		.map( component => component.toString( 16 ).padStart( 2, "0" ) ).join( "" )'.
!
toString
	^ 'QColor( ', self red toString, ', ', self green toString, ', ', self blue toString, ', ', self alpha toString, ' )'.
!
