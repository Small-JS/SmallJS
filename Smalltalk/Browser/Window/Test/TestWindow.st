CLASS TestWindow EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testPlatforms
	self assert: [ Window isFirefox | true ].
	self assert: [ Window isChromium | true ].
	self assert: [ Window isMacos | true ].
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
	self assert:[ window length >= 0 ].
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
	self assert:[ window sessionStorage class = Storage ].
	self assert:[ window statusBarVisible | true ].
	self assert:[ window toolBarVisible | true ].
	self assert:[ window top = window ].
	self assert:[ window visualViewport class = VisualViewport ].
!
testIframe
	"Test the relation between a window in an iframe and its parent window."
	| iframe frameWindow |
	iframe := Document default createElement: 'iframe'.
	Document default body appendChild: iframe.
	frameWindow := iframe contentWindow.
	self assert:[ frameWindow class = Window ].
	self assert:[ frameWindow parent = Window default ].
	self assert:[ frameWindow top = Window default ].
	self assert:[ frameWindow frameElement class = HtmlIframeElement ].
	self assert:[ frameWindow frameElement = iframe ].
	self assert:[ Window default frameElement isNil ].
	iframe remove.
!
testScrollTo
	"Test with a mock JS object, because the test page may not be scrollable."
	| window |
	window := Window fromJs: INLINE '( {
		scrollTo( x, y ) { this.scrolled = x + "," + y },
		resizeTo( x, y ) { this.resized = true } } )'.
	window scrollTo: 10 @ 20.
	self assert: [ ( window atJsProperty: 'scrolled' ) = '10,20' ].
	self assert: [ ( window atJsProperty: 'resized' ) isNil ].
!
testPostMessage
	"Test with a mock JS object, to check the conversion of the message to JS."
	| window |
	window := Window fromJs: INLINE '( {
		postMessage( message, targetOrigin ) { this.message = message; this.targetOrigin = targetOrigin } } )'.
	window postMessage: #( 1 'two' ) targetOrigin: '*'.
	self assert: [ Boolean fromJs: INLINE 'Array.isArray( window.js.message )' ].
	self assert: [ Boolean fromJs: INLINE 'window.js.message[ 1 ] === "two"' ].
	self assert: [ ( window atJsProperty: 'targetOrigin' ) = '*' ].
!
