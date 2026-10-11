CLASS TestMyWindow EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

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
	| window requestId |
	window := Window default.
	requestId := window requestAnimationFrame: [ :time | self onAnimationFrame: time ].
	self assert: [ requestId class = Integer ].
	requestId := window requestAnimationFrame: [ :time | self onCanceledAnimationFrame: time ].
	"Cancel previous request before it executes."
	window cancelAnimationFrame: requestId.
!
onAnimationFrame: time
	self assert: [ ( time class = Float ) & ( time > 0 ) ].
!
onCanceledAnimationFrame: time
	"This method should not get called."
	self assert: [ false ].
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
