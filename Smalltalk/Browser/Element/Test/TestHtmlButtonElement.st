CLASS TestHtmlButtonElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''
	"Form related properties of buttons are tested in TestHtmlFormElement."

test
	| button |
	button := Document new createElement: 'button'.
	self assert: [ button class = HtmlButtonElement ].

	self assert: [ button autofocus not ].
	button autofocus: true.
	self assert: [ button autofocus ].

	self assert: [ button disabled not ].
	button disabled: true.
	self assert: [ button disabled ].

	self assert: [ button labels isEmpty ].

	self assert: [ button name = '' ].
	button name: 'buttonName'.
	self assert: [ button name= 'buttonName' ].

	self assert: [ button tabIndex = 0 ].
	button tabIndex: -1.
	self assert: [ button tabIndex = -1 ].

	self assert: [ button type = 'submit' ].
	button type: 'button'.
	self assert: [ button type = 'button' ].

	self assert: [ button willValidate not ].
	self assert: [ button validationMessage = '' ].
	self assert: [ button valid ].

	self assert: [ button value = '' ].
!
