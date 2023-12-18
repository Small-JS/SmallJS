CLASS TestHtmlButtonElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''
	"Form related properties are tested in TestHtmlFormElement."

test
	| button |

	button := Document getElementById: 'button'.
	self assert: [ button class = HtmlButtonElement ].

	self assert: [ button autofocus not ].
	button autofocus: true.
	self assert: [ button autofocus ].
	button autofocus: false.

	self assert: [ button disabled not ].
	button disabled: true.
	self assert: [ button disabled ].
	button disabled: false.

	self assert: [ button labels first id = 'buttonOutputLabel' ].

	self assert: [ button name= 'buttonName' ].
	button name: 'buttonName2'.
	self assert: [ button name= 'buttonName2' ].
	button name: 'buttonName'.

	self assert: [ button tabIndex = 0 ].
	button tabIndex: -1.
	self assert: [ button tabIndex = -1 ].
	button tabIndex: 0.

	self assert: [ button type = 'submit' ].
	button type: 'button'.
	self assert: [ button type = 'button' ].
	button type: 'submit'.

	self assert: [ button willValidate ].
	self assert: [ button validationMessage = '' ].
	self assert: [ button valid ].
	self assert: [ button value = '' ].
!
testClick
	| button inactiveButton eventBlock |
	button := Document getElementById: 'button'.
	button addEventListener: 'click' then: [ :event | self onTestButton: event ].
	button click.

	inactiveButton := Document getElementById: 'inactiveButton'.
	eventBlock := [ :event | self onInactiveButton: event ].
	inactiveButton addEventListener: 'click' then: eventBlock.
	inactiveButton removeEventListener: 'click' then: eventBlock.
	self assert: [ inactiveButton eventIds length = 0 ].
!
onTestButton: event
	| buttonOutputLabel |
	buttonOutputLabel := Document getElementById: 'buttonOutputLabel'.
	buttonOutputLabel textContent: 'Test button clicked'.
!
onInactiveButton: event
	self error: 'Inactive Button should not trigger event.'.
!

