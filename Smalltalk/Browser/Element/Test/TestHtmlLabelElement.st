CLASS TestHtmlLabelElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| label checkboxLabel outputLabel |

	label := Document getElementById: 'label' class: HtmlLabelElement.
	self assert: [ label form isNil ].

	checkboxLabel := Document getElementById: 'checkboxLabel' class: HtmlLabelElement.
	self assert: [ checkboxLabel control class = HtmlInputElement ].

	self assert: [ checkboxLabel htmlFor = 'checkbox' ].
	checkboxLabel htmlFor: 'nothing'.
	self assert: [ checkboxLabel htmlFor = 'nothing' ].
	checkboxLabel htmlFor: 'checkbox'.

	outputLabel := Document getElementById: 'outputLabel' class: HtmlLabelElement.
	outputLabel textContent: label textContent.
!
