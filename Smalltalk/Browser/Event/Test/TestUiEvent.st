CLASS TestUiEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := UiEvent type: 'load'.
	self assert: [ event class = UiEvent ].
	self assert: [ event type = 'load' ].
	self assert: [ event detail = 0 ].
	self assert: [ event view isNil ].
!
testOptions
	| event options |
	options := UiEventOptions new detail: 2; view: Window default; bubbles: true; yourself.
	event := UiEvent type: 'click' options: options.
	self assert: [ event class = UiEvent ].
	self assert: [ event type = 'click' ].
	self assert: [ event detail = 2 ].
	self assert: [ event view = Window default ].
	self assert: [ event bubbles ].
!
testFromJsSubEvent
	| event |

	event := UiEvent fromJsSubEvent: INLINE 'new UIEvent( "load" )'.
	self assert: [ event class = UiEvent ].
	self assert: [ event type = 'load' ].

	event := UiEvent fromJsSubEvent: INLINE 'new MouseEvent( "click" )'.
	self assert: [ event class = MouseEvent ].
	self assert: [ event type = 'click' ].

	event := UiEvent fromJsSubEvent: INLINE 'new PointerEvent( "pointerdown" )'.
	self assert: [ event class = PointerEvent ].
	self assert: [ event type = 'pointerdown' ].

	"Fall back to Event fromJsSubEvent:"
	event := UiEvent fromJsSubEvent: INLINE 'new ErrorEvent( "error" )'.
	self assert: [ event class = ErrorEvent ].

	event := UiEvent fromJsSubEvent: INLINE 'new Event( "custom" )'.
	self assert: [ event class = Event ].
	self assert: [ event type = 'custom' ].
!
