CLASS TestInputComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| inputComponent input |
	inputComponent := MyBrowserApp default findComponent: InputComponent.
	input := inputComponent input.

	self assert: [ input name = 'inputName' ].
	self assert: [ input type = 'text' ].
	self assert: [ input value = 'My input' ].
	self assert: [ input autocomplete = 'on' ].
	self assert: [ input size = 20 ].
	self assert: [ #( 'forward' 'none' ) includes: input selectionDirection ].
!
testSelection
	| inputComponent input |
	inputComponent := MyBrowserApp default findComponent: InputComponent.
	input := inputComponent input.

	input selectionStart: 1.
	self assert: [ input selectionStart = 1 ].
	input selectionEnd: 4.
	self assert: [ input selectionEnd = 4 ].

	input select.
	self assert: [ input selectionStart = 0 ].
	self assert: [ input selectionEnd = input value length ].

	input setSelectionRange: 2 to: 5.
	self assert: [ input selectionStart = 2 ].
	self assert: [ input selectionEnd = 5 ].
!
testGui
	| inputComponent  |
	inputComponent := MyBrowserApp default findComponent: InputComponent.

	inputComponent outputButton click.
	Timer timeout: 500 then: [
			self assert: [ inputComponent outputLabel textContent = 'My input' ]  ].
!

