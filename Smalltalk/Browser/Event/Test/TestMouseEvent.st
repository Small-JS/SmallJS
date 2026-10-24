CLASS TestMouseEvent EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testNew
	| event |
	event := MouseEvent type: 'click'.
	self assert: [ event class = MouseEvent ].
	self assert: [ event type = 'click' ].
	self assert: [ event altKey not ].
	self assert: [ event ctrlKey not ].
	self assert: [ event metaKey not ].
	self assert: [ event shiftKey not ].
	self assert: [ ( event modifierState: 'Control' ) not ].
	self assert: [ event button = 0 ].
	self assert: [ event buttons = 0 ].
	self assert: [ event client = ( 0 @ 0 ) ].
	self assert: [ event screen = ( 0 @ 0 ) ].
	self assert: [ event movement = ( 0 @ 0 ) ].
	self assert: [ event relatedTarget isNil ].
!
testOptions
	| event options |
	options := MouseEventOptions new
		altKey: true; ctrlKey: true; metaKey: false; shiftKey: true;
		button: 2; buttons: 3;
		clientX: 10; clientY: 20;
		screenX: 110; screenY: 120;
		movementX: 1; movementY: -2;
		relatedTarget: Window default;
		detail: 1; bubbles: true.
	event := MouseEvent type: 'mousedown' options: options.
	self assert: [ event class = MouseEvent ].
	self assert: [ event type = 'mousedown' ].
	self assert: [ event altKey ].
	self assert: [ event ctrlKey ].
	self assert: [ event metaKey not ].
	self assert: [ event shiftKey ].
	self assert: [ event modifierState: 'Alt' ].
	self assert: [ event modifierState: 'Control' ].
	self assert: [ ( event modifierState: 'Meta' ) not ].
	self assert: [ event modifierState: 'Shift' ].
	self assert: [ event button = 2 ].
	self assert: [ event buttons = 3 ].
	self assert: [ event client = ( 10 @ 20 ) ].
	self assert: [ event screen = ( 110 @ 120 ) ].
	self assert: [ event movement = ( 1 @ -2 ) ].
	self assert: [ event page notNil ].
	self assert: [ event offset notNil ].
	self assert: [ event relatedTarget = Window default ].
	self assert: [ event relatedTarget class = Window ].
	self assert: [ event detail = 1 ].
	self assert: [ event bubbles ].
!
testRelatedTargetElement
	| div options event |
	div := Document new createElement: 'div'.
	options := MouseEventOptions new relatedTarget: div.
	event := MouseEvent type: 'mouseover' options: options.
	self assert: [ event relatedTarget = div ].
	self assert: [ event relatedTarget class = HtmlDivElement ].
!
testListener
	"Listeners on nodes and the window receive ST MouseEvent and PointerEvent objects."
	| div options mouseEvent pointerEvent customEvent received block |
	div := Document new createElement: 'div'.
	div addEventListener: 'mousedown' then: [ :event | received := event ].
	options := MouseEventOptions new clientX: 5; clientY: 6.
	mouseEvent := MouseEvent type: 'mousedown' options: options.
	div dispatchEvent: mouseEvent.
	self assert: [ received class = MouseEvent ].
	self assert: [ received client = ( 5 @ 6 ) ].

	received := nil.
	div addEventListener: 'click' then: [ :event | received := event ].
	div click.
	self assert: [ received isKindOf: MouseEvent ].

	received := nil.
	block := [ :event | received := event ].
	Window default addEventListener: 'pointerdown' then: block.
	pointerEvent := PointerEvent type: 'pointerdown'.
	Window default dispatchEvent: pointerEvent.
	Window default removeEventListener: 'pointerdown' then: block.
	self assert: [ received class = PointerEvent ].

	"Non UI events still become their Core Event class."
	received := nil.
	div addEventListener: 'custom' then: [ :event | received := event ].
	customEvent := Event type: 'custom'.
	div dispatchEvent: customEvent.
	self assert: [ received class = Event ].
!
