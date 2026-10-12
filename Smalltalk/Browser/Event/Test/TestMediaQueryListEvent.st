CLASS TestMediaQueryListEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := MediaQueryListEvent type: 'change'.
	self assert: [ event class = MediaQueryListEvent ].
	self assert: [ event type = 'change' ].
	self assert: [ event matches not ].
	self assert: [ event media = '' ].
!
testOptions
	| event options |
	options := MediaQueryListEventOptions new matches: true; media: '(min-width: 100px)'; bubbles: true.
	event := MediaQueryListEvent type: 'change' options: options.
	self assert: [ event class = MediaQueryListEvent ].
	self assert: [ event type = 'change' ].
	self assert: [ event matches ].
	self assert: [ event media = '(min-width: 100px)' ].
	self assert: [ event bubbles ].
!
testDispatch
	| list received |
	list := Window default matchMedia: 'screen'.
	list onChange: [ :event | received := event ].
	list dispatchEvent: ( MediaQueryListEvent type: 'change'
		options: ( MediaQueryListEventOptions new matches: true; media: 'screen' ) ).
	self assert: [ received class = MediaQueryListEvent ].
	self assert: [ received matches ].
	self assert: [ received media = 'screen' ].
!
