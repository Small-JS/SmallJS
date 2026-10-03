CLASS TestRectangle EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreatiing
	self assert: [ ( Rect origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) class = Rect ].
	"Any JS object with DOMRect properties works, so fromJs: can be tested outside a browser."
	self assert: [ ( Rect fromJs: ( INLINE '{ x: 1, y: 2, width: 3, height: 4 }' ) ) = ( Rect origin: ( 1 @ 2 ) extent: ( 3 @ 4 ) ) ].
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
