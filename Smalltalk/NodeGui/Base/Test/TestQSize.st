CLASS TestQSize EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| size |
	size := QSize new.
	self assert: [ size jsClassName = 'QSize' ].
	self assert: [ size width = -1 ].
	self assert: [ size height = -1 ].

	size := QSize width: 30 height: 20.
	self assert: [ size width = 30 ].
	self assert: [ size height = 20 ].
	size setWidth: 40; setHeight: 50.
	self assert: [ size width = 40 ].
	self assert: [ size height = 50 ].

	"A zero width is not mistaken for no arguments."
	size := QSize width: 0 height: 20.
	self assert: [ size width = 0 ].
	self assert: [ size height = 20 ].
!
testComparing
	self assert: [ ( QSize width: 30 height: 20 ) = ( QSize width: 30 height: 20 ) ].
	self assert: [ ( QSize width: 30 height: 20 ) ~= ( QSize width: 30 height: 21 ) ].
	self assert: [ ( QSize width: 30 height: 20 ) ~= ( QSize width: 31 height: 20 ) ].
	self assert: [ ( QSize width: 30 height: 20 ) ~= 30 ].
!
testTesting
	| size |
	size := QSize new.
	self assert: [ size isValid not ].
	self assert: [ size isEmpty ].
	self assert: [ size isNull not ].

	size := QSize width: 0 height: 0.
	self assert: [ size isValid ].
	self assert: [ size isEmpty ].
	self assert: [ size isNull ].

	size := QSize width: 30 height: 0.
	self assert: [ size isValid ].
	self assert: [ size isEmpty ].
	self assert: [ size isNull not ].

	size := QSize width: 30 height: 20.
	self assert: [ size isValid ].
	self assert: [ size isEmpty not ].
	self assert: [ size isNull not ].
!
testBoundedExpanded
	| size1 size2 |
	size1 := QSize width: 30 height: 20.
	size2 := QSize width: 10 height: 40.
	self assert: [ ( size1 boundedTo: size2 ) = ( QSize width: 10 height: 20 ) ].
	self assert: [ ( size1 expandedTo: size2 ) = ( QSize width: 30 height: 40 ) ].
	"The receiver is not changed."
	self assert: [ size1 = ( QSize width: 30 height: 20 ) ].
!
testTranspose
	| size |
	size := QSize width: 30 height: 20.
	self assert: [ size transposed = ( QSize width: 20 height: 30 ) ].
	self assert: [ size = ( QSize width: 30 height: 20 ) ].
	size transpose.
	self assert: [ size = ( QSize width: 20 height: 30 ) ].
!
testScale
	| size target |
	size := QSize width: 30 height: 20.
	target := QSize width: 60 height: 60.
	self assert: [ ( size scaled: target mode: QSize ignoreAspectRatio ) = ( QSize width: 60 height: 60 ) ].
	self assert: [ ( size scaled: target mode: QSize keepAspectRatio ) = ( QSize width: 60 height: 40 ) ].
	self assert: [ ( size scaled: target mode: QSize keepAspectRatioByExpanding ) = ( QSize width: 90 height: 60 ) ].
	"The receiver is not changed by scaled:, but is by scale:."
	self assert: [ size = ( QSize width: 30 height: 20 ) ].
	size scale: target mode: QSize keepAspectRatio.
	self assert: [ size = ( QSize width: 60 height: 40 ) ].
!
testFromVariant
	| widget size |
	widget := QWidget new.
	widget setProperty: 'minimumSize' value: ( QSize width: 30 height: 20 ).
	size := QSize fromVariant: ( widget property: 'minimumSize' ).
	self assert: [ size = ( QSize width: 30 height: 20 ) ].
!
testToString
	self assert: [ ( QSize width: 30 height: 20 ) toString = 'QSize( 30, 20 )' ].
!
