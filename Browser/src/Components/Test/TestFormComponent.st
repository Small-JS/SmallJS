CLASS TestFormComponent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| formComponent formElement |
	formComponent := MyBrowserApp default findComponent: FormComponent.
	formElement := formComponent formElement.

	self assert: [ formElement name = 'formName' ].
	self assert: [ formElement action endsWith: 'Components/FormTarget.html' ].
	self assert: [ formElement target = '_blank' ].

	"Test of submit button not done here (yet) because it is too disruptive."
!
