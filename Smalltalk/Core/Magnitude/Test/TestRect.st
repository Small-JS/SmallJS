CLASS TestRectangle EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreatiing
	self assert: [ ( Rect origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) class = Rect ].
	"Method fromJs: jsDOMRect can only be tested in a browser environment."
!
testConverting
	self assert: [ ( Rect origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) toString = 'Rect( ( 1 @ 2 ) , ( 3 @ 4 ) )' ].
!
testAccessing
	| rectangle |
	rectangle := Rect new origin: ( 1 @ 2 ) extent: ( 3 @ 4 ).
	self assert: [ rectangle origin = ( 1 @ 2 ) ].
	self assert: [ rectangle extent = ( 3 @ 4 ) ].
!
testComparing
	self assert: [ ( Rect origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) = ( Rect origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) ].
!
