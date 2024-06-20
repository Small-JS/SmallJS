CLASS TestNamedNodeMap EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| document input namedNodeMap attr |
	document := Document new.

	input := document createElement: 'input'.
	self assert: [ input class = HtmlInputElement ].
	input id: 'myInput'; type: 'checkbox'; readOnly: true.

	namedNodeMap := input attributes.
	self assert: [ namedNodeMap length = 3 ].
	self assert: [ ( namedNodeMap getNamedItem: 'type' ) value = 'checkbox' ].
	self assert: [ ( namedNodeMap item: 1 ) name = 'id' ].

	"Attribute name should be lowercase."
	attr := document createAttribute: 'my-name'.
	attr value: 'myValue'.
	namedNodeMap setNamedItem: attr.
	self assert: [ ( namedNodeMap getNamedItem: 'my-name' ) value = 'myValue' ].

	namedNodeMap removeNamedItem: 'my-name'.
	self assert: [ ( namedNodeMap getNamedItem: 'my-name' ) = nil ].
!
