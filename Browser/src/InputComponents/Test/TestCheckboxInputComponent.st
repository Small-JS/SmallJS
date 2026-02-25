CLASS TestCheckboxInputComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| checkboxInputComponent checkboxInput |
	checkboxInputComponent := MyBrowserApp default findComponent: CheckboxInputComponent.
	checkboxInput := checkboxInputComponent checkboxInput.

	self assert: [ checkboxInput type = 'checkbox' ].
	self assert: [ checkboxInput checked not ].
!
async testGui
	| checkboxInputComponent |
	checkboxInputComponent := MyBrowserApp default findComponent: CheckboxInputComponent.

	checkboxInputComponent checkboxInput click.
	await Timer timeout: 500.
	self assert: [ checkboxInputComponent outputParagraph textContent = 'Checked' ].
!
