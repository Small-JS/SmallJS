CLASS TestMyWindow EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

METHODS

testCallback
	| handle window |
	window := Window default.
	window requestIdleCallback: [ self onCallback ] timeout: 10.
	handle := window requestIdleCallback: [ self onCanceledCallback ] timeout: 1000.
	"Cancel previous callback before it executes."
	window cancelIdleCallback: handle.
!
onCallback
	self assert: [ true ].
!
onCanceledCallback
	"This method should not get called."
	self assert: [ false ].
!
testAnimation
	"Todo: Test this with Animation class:
		requestAnimationFrame: callback
		cancelAnimationFrame: requestId"
!
testOtherMethods
	| window element |
	window := Window default.

	window blur.
	window focus.
	element := Document getElementById: 'welcomeTitle' class: HtmlParagraphElement.
	self assert:[ ( window getComputedStyle: element ) class = CssStyleDeclaration ].
	self assert:[ ( window matchMedia: 'myMedia' ) class = MediaQueryList ].
!
