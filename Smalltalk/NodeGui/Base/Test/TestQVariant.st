CLASS TestQVariant EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	self assert: [ ( QVariant new: 'abc' ) toString = 'abc' ].
	self assert: [ ( QVariant new: 42 ) toInt = 42 ].
	self assert: [ ( QVariant new: 1.5 ) toDouble = 1.5 ].
	self assert: [ ( QVariant new: true ) toBool ].
	self assert: [ ( QVariant new: #( 'a' 'b' ) ) toStringList = #( 'a' 'b' ) ].

	"Conversions between types."
	self assert: [ ( QVariant new: '12' ) toInt = 12 ].
	self assert: [ ( QVariant new: 12 ) toString = '12' ].
!
