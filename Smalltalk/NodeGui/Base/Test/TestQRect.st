CLASS TestQRect EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| rect |
	rect := QRect new.
	self assert: [ rect jsClassName = 'QRect' ].
	self assert: [ rect width = 0 ].
	self assert: [ rect height = 0 ].

	rect := QRect left: 10 top: 20 width: 30 height: 40.
	self assert: [ rect left = 10 ].
	self assert: [ rect top = 20 ].
	self assert: [ rect width = 30 ].
	self assert: [ rect height = 40 ].
	self assert: [ rect topLeft = ( QPoint x: 10 y: 20 ) ].
	self assert: [ rect size = ( QSize width: 30 height: 40 ) ].

	rect setWidth: 50; setHeight: 60.
	self assert: [ rect size = ( QSize width: 50 height: 60 ) ].
!
testEdges
	"Moving the left or top edge changes the width or height."
	| rect |
	rect := QRect left: 10 top: 20 width: 30 height: 40.
	rect setLeft: 0.
	self assert: [ rect width = 40 ].
	rect setTop: 30.
	self assert: [ rect height = 30 ].
!
testComparing
	self assert: [ ( QRect left: 1 top: 2 width: 3 height: 4 ) = ( QRect left: 1 top: 2 width: 3 height: 4 ) ].
	self assert: [ ( QRect left: 1 top: 2 width: 3 height: 4 ) ~= ( QRect left: 1 top: 2 width: 3 height: 5 ) ].
	self assert: [ ( QRect left: 1 top: 2 width: 3 height: 4 ) ~= 1 ].
!
testFromVariant
	| widget |
	widget := QWidget new.
	widget setGeometry: ( QRect left: 10 top: 20 width: 30 height: 40 ).
	self assert: [ ( QRect fromVariant: ( widget property: 'geometry' ) ) = ( QRect left: 10 top: 20 width: 30 height: 40 ) ].
!
testToString
	self assert: [ ( QRect left: 1 top: 2 width: 3 height: 4 ) toString = 'QRect( 1, 2, 3, 4 )' ].
!
