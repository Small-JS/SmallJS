CLASS TestHtmlLabelElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
test
	| label checkboxLabel outputLabel |

	label := Document default getElementById: 'label'.
	self assert: [ label class = HtmlLabelElement ].
	self assert: [ label form isNil ].

	checkboxLabel := Document default getElementById: 'checkboxLabel'.
	self assert: [ checkboxLabel control class = HtmlInputElement ].

	self assert: [ checkboxLabel htmlFor = 'checkbox' ].
	checkboxLabel htmlFor: 'nothing'.
	self assert: [ checkboxLabel htmlFor = 'nothing' ].
	checkboxLabel htmlFor: 'checkbox'.

	outputLabel := Document default getElementById: 'outputLabel'.
	outputLabel textContent: label textContent.
!
