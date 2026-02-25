CLASS TestDateInputComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

test
	| dateInputComponent dateInput |
	dateInputComponent := MyBrowserApp default findComponent: DateInputComponent.
	dateInput := dateInputComponent dateInput.

	self assert: [ dateInput type = 'date' ].
	self assert: [ dateInput value = '1900-01-01' ].
!
