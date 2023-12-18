CLASS TestHtmlLabelElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| label checkboxLabel outputLabel |

	label := Document getElementById: 'label'.
	self assert: [ label class = HtmlLabelElement ].
	self assert: [ label form isNil ].

	checkboxLabel := Document getElementById: 'checkboxLabel'.
	self assert: [ checkboxLabel control class = HtmlInputElement ].

	self assert: [ checkboxLabel htmlFor = 'checkbox' ].
	checkboxLabel htmlFor: 'nothing'.
	self assert: [ checkboxLabel htmlFor = 'nothing' ].
	checkboxLabel htmlFor: 'checkbox'.

	outputLabel := Document getElementById: 'outputLabel'.
	outputLabel textContent: label textContent.
!
