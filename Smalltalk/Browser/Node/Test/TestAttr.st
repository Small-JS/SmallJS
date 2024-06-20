CLASS TestAttr EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| attr |
	"Attributes names should be lower case."
	attr := Document new createAttribute: 'my-name'.
	self assert: [ attr class = Attr ].
	self assert: [ attr name = 'my-name' ].

	attr value: 'myValue'.
	self assert: [ attr value = 'myValue' ].
!
