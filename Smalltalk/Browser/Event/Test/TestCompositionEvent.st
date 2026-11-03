CLASS TestCompositionEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := CompositionEvent type: 'compositionstart'.
	self assert: [ event class = CompositionEvent ].
	self assert: [ event type = 'compositionstart' ].
	self assert: [ event data = '' ].
!
testOptions
	| options event |
	options := CompositionEventOptions new data: 'nihon'; detail: 1.
	event := CompositionEvent type: 'compositionend' options: options.
	self assert: [ event class = CompositionEvent ].
	self assert: [ event type = 'compositionend' ].
	self assert: [ event data = 'nihon' ].
	"Inherited options"
	self assert: [ event detail = 1 ].
!
testListener
	| input options received |
	input := Document new createElement: 'input'.
	input addEventListener: 'compositionupdate' then: [ :event | received := event ].
	options := CompositionEventOptions new data: 'ni'.
	input dispatchEvent: ( CompositionEvent type: 'compositionupdate' options: options ).
	self assert: [ received class = CompositionEvent ].
	self assert: [ received data = 'ni' ].
!
