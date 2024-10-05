CLASS TestQObject EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| object |
	object := QObject new.
	self assert: [ object jsClassName = 'QObject' ].

	object setObjectName: 'myObjectName'.
	self assert: [ object objectName = 'myObjectName' ].
!
