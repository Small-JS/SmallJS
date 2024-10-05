CLASS TestQIcon EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| icon |
	icon := QIcon new: 'missing.ico'.

	self assert: [ icon name = '' ].
!
