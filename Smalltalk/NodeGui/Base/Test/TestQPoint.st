CLASS TestQPoint EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| point |
	point := QPoint new.
	self assert: [ point jsClassName = 'QPoint' ].
	self assert: [ point x = 0 ].
	self assert: [ point y = 0 ].
	self assert: [ point isZero ].

	point := QPoint x: 30 y: -20.
	self assert: [ point x = 30 ].
	self assert: [ point y = -20 ].
	self assert: [ point isZero not ].
	point setX: 40; setY: 50.
	self assert: [ point x = 40 ].
	self assert: [ point y = 50 ].
!
testComparing
	self assert: [ ( QPoint x: 30 y: 20 ) = ( QPoint x: 30 y: 20 ) ].
	self assert: [ ( QPoint x: 30 y: 20 ) ~= ( QPoint x: 30 y: 21 ) ].
	self assert: [ ( QPoint x: 30 y: 20 ) ~= 30 ].
!
testConverting
	| point |
	point := QPoint x: 30 y: -20.
	self assert: [ point manhattanLength = 50 ].
	self assert: [ point transposed = ( QPoint x: -20 y: 30 ) ].
	self assert: [ point = ( QPoint x: 30 y: -20 ) ].
!
testFromVariant
	| widget |
	widget := QWidget new.
	widget move: ( QPoint x: 30 y: 20 ).
	self assert: [ ( QPoint fromVariant: ( widget property: 'pos' ) ) = ( QPoint x: 30 y: 20 ) ].
!
testToString
	self assert: [ ( QPoint x: 30 y: 20 ) toString = 'QPoint( 30, 20 )' ].
!
