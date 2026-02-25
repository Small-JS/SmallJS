CLASS TestRadioInputComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| radioInputComponent radioInput1 radioInput2 |
	radioInputComponent := MyBrowserApp default findComponent: RadioInputComponent.
	radioInput1 := radioInputComponent radioInput1.
	radioInput2 := radioInputComponent radioInput2.

	self assert: [ radioInput1 type = 'radio' ].
	self assert: [ radioInput1 name = 'radioSelect' ].
	self assert: [ radioInput1 value = 'radio1' ].
	self assert: [ radioInput1 checked ].

	self assert: [ radioInput2 type = 'radio' ].
	self assert: [ radioInput2 name = 'radioSelect' ].
	self assert: [ radioInput2 value = 'radio2' ].
	self assert: [ radioInput2 checked not ].
!
async testGui
	| radioInputComponent |
	radioInputComponent := MyBrowserApp default findComponent: RadioInputComponent.

	radioInputComponent radioInput2 click.
	await Timer timeout: 500.
	self assert: [ radioInputComponent outputParagraph textContent = 'Radio 2' ].
!
