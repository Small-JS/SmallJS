CLASS TestCheckboxInputComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| checkboxInputComponent checkboxInput |
	checkboxInputComponent := MyBrowserApp default findComponent: CheckboxInputComponent.
	checkboxInput := checkboxInputComponent checkboxInput.

	self assert: [ checkboxInput type = 'checkbox' ].
	self assert: [ checkboxInput checked not ].
!
testGui
	| checkboxInputComponent |
	checkboxInputComponent := MyBrowserApp default findComponent: CheckboxInputComponent.

	checkboxInputComponent checkboxInput click.
	Timer timeout: 500 then: [
			self assert: [ checkboxInputComponent outputParagraph textContent = 'Checked' ] ]."
!
