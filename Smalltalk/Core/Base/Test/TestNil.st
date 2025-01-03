CLASS TestNil EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ nil class = Nil ].
	self assert: [ nil isNull ].
	self assert: [ nil isNil ].
	self assert: [ nil toString = 'nil' ].

	self assert: [ ( Nil fromJs: INLINE 'null' ) = nil ].
	self assert: [ ( Nil fromJs: INLINE 'undefined' ) = nil ].
	self assert: [ ( Nil fromJs: 3 ) = 3 ].

	self assert: [ nil ifNil: [ true ] ].
	self assert: [ 1 ifNotNil: [ true ] ].
!
