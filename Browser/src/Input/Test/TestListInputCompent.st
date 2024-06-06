CLASS TestListInputCompent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| listInputComponent dataList options |
	listInputComponent := MyBrowserApp default findComponent: ListInputComponent.
	dataList := listInputComponent dataList.

	options := dataList options.
	self assert: [ options length = 2 ].
	self assert: [ options first value = 'First' ].
	self assert: [ ( dataList indexOf: 'Second' ) = 1 ].
	self assert: [ ( dataList indexOf: 'Missing' ) = -1 ].
!
testGui
	| listInputComponent |
	listInputComponent := MyBrowserApp default findComponent: ListInputComponent.

	listInputComponent listInput value: listInputComponent dataList options last value.
	listInputComponent listInput dispatchEvent: ( Event type: 'input' ).
	Timer timeout: 500 then: [
		self assert: [ listInputComponent outputLabel textContent = 'Second' ] ]."
!
