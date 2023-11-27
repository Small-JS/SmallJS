CLASS TestWindow EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

METHODS

testPlatforms
	self assert: [ Window isFirefox | true ].
	self assert: [ Window isChromium | true ].
	self assert: [ Window isMac | true ].
!
testProperties
	| window |
	window := Window default.

	self assert:[ window class = Window ].
	self assert:[ window closed not ].
	self assert:[ window console = Console ].
	self assert:[ window customElements class = CustomElementRegistry ].
	self assert:[ window devicePixelRatio > 0.0 ].
	self assert:[ window document = Document default ].
	self assert:[ window frameElement isNil ].
	self assert:[ window frames class = Window ].
	self assert:[ window history class = History ].
	self assert:[ window innerHeight > 0 ].
	self assert:[ window innerWidth > 0 ].
	"Note: Firefox creates dynamic iframe elements async, so length is updated later."
	self assert:[ window length >= 1 ].
	self assert:[ window localStorage class = Storage ].
	self assert:[ window location class = Location ].
	self assert:[ window locationBarVisible ].
	self assert:[ window menuBarVisible ].
	self assert:[ window navigator class = Navigator ].
	self assert:[ window opener isNil ].
	self assert:[ window outerHeight > 0 ].
	self assert:[ window outerWidth > 0 ].
	self assert:[ window pageXOffset >= 0 ].
	self assert:[ window pageYOffset >= 0 ].
	self assert:[ window parent = window ].
	self assert:[ window personalBarVisible ].
	self assert:[ window screen class = Screen ].
	self assert:[ window scrollBarsVisible | true ].
	self assert:[ window scrollX >= 0 ].
	self assert:[ window scrollY >= 0 ].
	self assert:[ window self class = Window ].
	self assert:[ window sessionStorage class = Storage ].
	self assert:[ window speechSynthesis class = SpeechSynthesis ].
	self assert:[ window statusBarVisible | true ].
	self assert:[ window toolBarVisible | true ].
	self assert:[ window top = window ].
	self assert:[ window visualViewport class = VisualViewport ].
	self assert:[ window window = window ].
!
testCallback
	| handle window |
	window := Window default.
	window requestIdleCallback: [ self onCallback ] timeout: 10.
	handle := window requestIdleCallback: [ self onDontCallback ] timeout: 1000.
	"Cancel previous callback before it executes."
	window cancelIdleCallback: handle.
!
onCallback
	| label |
	label := Document default getElementById: 'callbackLabel'.
	label textContent: 'Called back!'.
!
onDontCallback
	self error: 'Callback should have been canceled.'
!
testAnimation
	"Todo: Test this with Animation class:
		requestAnimationFrame: callback
		cancelAnimationFrame: requestId"
!
testOpenMoveClose
	"This test requires popups to be enabled in the browser."
	| window |
	window := Window default open: '' target: '' features: 'width=400, height=400'.
	window isNil ifTrue: [ self error: 'Failed to create Window. Enable popups in browser.' ].

	"Firefox moves windows async so these tests fail."
	Window isFirefox not ifTrue: [
		window moveTo: ( 200 @ 100 ).
		self assert: [ window screenPos = ( 200 @ 100 ) ].
		window moveBy: ( 100 @ 50 ).
		self assert: [ window screenPos = ( 300 @ 150 ) ].
		window resizeBy: ( 200 @ 200 ).
		window resizeTo: ( 100 @ 100 ) ].

	window stop.
	window close.

!
testDialogs
	"Testing these should be done manually in the browser."
	| window document |

	document := Document default.

	( document getElementById: 'alertButton' ) onClick: [ :event | self onAlert ].
	( document getElementById: 'confirmButton' ) onClick: [ :event | self onConfirm ].
	( document getElementById: 'promptButton' ) onClick: [ :event | self onPrompt ].
	( document getElementById: 'printButton' ) onClick: [ :event | self onPrint ].
!
onAlert
	Window default alert: 'My Alert'.
!
onConfirm
	| result |
	result := Window default confirm: 'My Confirm'.
	( Document default getElementById: 'dialogResultLabel' ) textContent: result toString.
!
onPrompt
	| result |
	result := Window default prompt: 'My Prompt'.
	( Document default getElementById: 'dialogResultLabel' ) textContent: result toString.
!
onPrint
	Window default print.
!
testOtherMethods
	| window element |
	window := Window default.

	window blur.
	window focus.
	element := Document default getElementById: 'welcomeTitle'.
	self assert:[ ( window getComputedStyle: element ) class = CssStyleDeclaration ].
	self assert:[ ( window matchMedia: 'myMedia' ) class = MediaQueryList ].

	"window postMessage: message targetOrigin: targetOrigin."
	"window print."
!
