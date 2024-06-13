CLASS TestRectangle EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreatiing
	self assert: [ ( Rectangle origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) class = Rectangle ].
	"Method fromJs: jsDOMRect can only be tested in a browser environment."
!
testConverting
	self assert: [ ( Rectangle origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) toString = 'Rectangle( ( 1 @ 2 ) , ( 3 @ 4 ) )' ].
!
testAccessing
	| rectangle |
	rectangle := Rectangle new origin: ( 1 @ 2 ) extent: ( 3 @ 4 ).
	self assert: [ rectangle origin = ( 1 @ 2 ) ].
	self assert: [ rectangle extent = ( 3 @ 4 ) ].
!
testComparing
	self assert: [ ( Rectangle origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) = ( Rectangle origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) ].
!
