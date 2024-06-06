CLASS TestAttr EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| attr |

	attr := ( Document getElementById: 'smallJsLogo' class: HtmlImageElement ) attributes item: 1.
	self assert: [ attr localName = 'id' ].
	self assert: [ attr name = 'id' ].
	self assert: [ attr value = 'smallJsLogo' ].

	attr := Document default createAttribute: 'myname'.		"Should be lower case."
	attr value: 'myValue'.
	self assert: [ attr name = 'myname' ].
	self assert: [ attr value = 'myValue' ].
!
