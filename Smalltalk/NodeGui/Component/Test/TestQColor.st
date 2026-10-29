CLASS TestQColor EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| color |
	color := QColor red: 10 green: 20 blue: 30.
	self assert: [ color jsClassName = 'QColor' ].
	self assert: [ color red = 10 ].
	self assert: [ color green = 20 ].
	self assert: [ color blue = 30 ].
	self assert: [ color alpha = 255 ].

	color := QColor red: 10 green: 20 blue: 30 alpha: 40.
	self assert: [ color alpha = 40 ].
	color setRed: 50; setGreen: 60; setBlue: 70; setAlpha: 80.
	self assert: [ color = ( QColor red: 50 green: 60 blue: 70 alpha: 80 ) ].
!
testNamed
	self assert: [ ( QColor named: 'red' ) = ( QColor red: 255 green: 0 blue: 0 ) ].
	self assert: [ ( QColor named: '#ff8000' ) = ( QColor red: 255 green: 128 blue: 0 ) ].
	self assert: [ ( QColor red: 255 green: 128 blue: 0 ) name = '#ff8000' ].
	self assert: [ ( QColor red: 1 green: 2 blue: 3 ) name = '#010203' ].
!
testHsvHsl
	self assert: [ ( QColor hue: 120 saturation: 255 value: 255 ) = ( QColor red: 0 green: 255 blue: 0 ) ].
	self assert: [ ( QColor hue: 0 saturation: 0 lightness: 255 ) = ( QColor red: 255 green: 255 blue: 255 ) ].
	self assert: [ ( QColor hue: 0 saturation: 0 lightness: 0 ) = ( QColor red: 0 green: 0 blue: 0 ) ].
!
testRgb
	| color |
	"Hex 0x40102030 and 0xFF102030."
	color := QColor red: 16 green: 32 blue: 48 alpha: 64.
	self assert: [ color rgba = 1074798640 ].
	self assert: [ color rgb = 4279246896 ].
!
testComparing
	self assert: [ ( QColor red: 1 green: 2 blue: 3 ) = ( QColor red: 1 green: 2 blue: 3 ) ].
	self assert: [ ( QColor red: 1 green: 2 blue: 3 ) ~= ( QColor red: 1 green: 2 blue: 4 ) ].
	self assert: [ ( QColor red: 1 green: 2 blue: 3 ) ~= ( QColor red: 1 green: 2 blue: 3 alpha: 4 ) ].
	self assert: [ ( QColor red: 1 green: 2 blue: 3 ) ~= 1 ].
!
testToString
	self assert: [ ( QColor red: 1 green: 2 blue: 3 ) toString = 'QColor( 1, 2, 3, 255 )' ].
!
