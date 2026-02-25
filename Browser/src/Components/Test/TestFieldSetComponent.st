CLASS TestFieldSetComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| fieldSetComponent fieldSetElement elements |
	fieldSetComponent := MyBrowserApp default findComponent: FieldSetComponent.
	fieldSetElement := fieldSetComponent fieldSetElement.

	elements := fieldSetElement elements.
	self assert: [ ( elements at: 0 ) class = HtmlInputElement ].
	self assert: [ ( elements at: 1 ) class = HtmlInputElement ].
!
