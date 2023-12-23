CLASS TestNamedNodeMap EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| namedNodeMap attr |
	namedNodeMap := ( Document getElementById: 'smallJsLogo' class: HtmlImageElement ) attributes.

	self assert: [ namedNodeMap length = 5 ].
	self assert: [ ( namedNodeMap getNamedItem: 'src' ) value = 'SmallJS.png' ].
	self assert: [ ( namedNodeMap item: 1 ) name = 'id' ].

	"Attribute name should be lowercase."
	attr := Document default createAttribute: 'myname'.
	attr value: 'myValue'.
	namedNodeMap setNamedItem: attr.
	self assert: [ ( namedNodeMap getNamedItem: 'myname' ) value = 'myValue' ].

	namedNodeMap removeNamedItem: 'myName'.
	self assert: [ ( namedNodeMap getNamedItem: 'myName' ) = nil ].
!

