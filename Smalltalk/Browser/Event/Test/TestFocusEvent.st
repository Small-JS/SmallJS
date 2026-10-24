CLASS TestFocusEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := FocusEvent type: 'focus'.
	self assert: [ event class = FocusEvent ].
	self assert: [ event type = 'focus' ].
	self assert: [ event relatedTarget isNil ].
!
testOptions
	| div options event |
	div := Document new createElement: 'div'.
	options := FocusEventOptions new relatedTarget: div; detail: 1; bubbles: true.
	event := FocusEvent type: 'focusin' options: options.
	self assert: [ event class = FocusEvent ].
	self assert: [ event type = 'focusin' ].
	self assert: [ event relatedTarget = div ].
	self assert: [ event relatedTarget class = HtmlDivElement ].
	"Inherited options"
	self assert: [ event detail = 1 ].
	self assert: [ event bubbles ].
!
testListener
	| input received |
	input := Document new createElement: 'input'.
	input addEventListener: 'blur' then: [ :event | received := event ].
	input dispatchEvent: ( FocusEvent type: 'blur' ).
	self assert: [ received class = FocusEvent ].
	self assert: [ received type = 'blur' ].
!
