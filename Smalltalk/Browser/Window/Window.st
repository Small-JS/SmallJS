CLASS Window EXTENDS EventTarget MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS 'window' class."

CLASSMETHODS

new
	^ self default.
!
default
	^ self fromJs: INLINE 'window'.
!
isFirefox
	"Shortcut method to test for Firefox browser."
	^ self default navigator userAgent includes: 'Firefox'.
!
isChromium
	"Shortcut method to test for Cromium based browser: Chrome or Edge."
	^ self default navigator userAgent includes: 'Chrome'.
!

METHODS

"Properties."

closed
	^ Boolean fromJs: INLINE 'this.js.closed'.
!
console
	^ Console.
!
customElements
	^ CustomElementRegistry fromJs: INLINE 'this.js.customElements'.
!
devicePixelRatio
	^ Float fromJs: INLINE 'this.js.devicePixelRatio'.
!
document
	^ Document fromJs: INLINE 'this.js.document'.
!
frameElement
	^ Element fromJsSubElement: INLINE 'this.js.frameElement'.
!
frames
	"Strangely enough, just the Window itself is returned in JS, not an array..."
	"^ Array fromJs: INLINE 'this.js.frames'
		elementConverter: [ :window | Window fromJs: window ]."
	^ Window fromJs: INLINE 'this.js.frames'.
!
history
	^ History fromJs: INLINE 'this.js.history'.
!
innerHeight
	^ Integer fromJs: INLINE 'this.js.innerHeight'.
!
innerWidth
	^ Integer fromJs: INLINE 'this.js.innerWidth'.
!
length
	^ Integer fromJs: INLINE 'this.js.length'.
!
localStorage
	^ Storage fromJs: INLINE 'this.js.localStorage'.
!
location
	^ Location fromJs: INLINE 'this.js.location'.
!
locationBarVisible
	^ Boolean fromJs: INLINE 'this.js.locationbar.visible'.
!
menuBarVisible
	^ Boolean fromJs: INLINE 'this.js.menubar.visible'.
!
navigator
	^ Navigator fromJs: INLINE 'this.js.navigator'.
!
opener
	^ Window fromJs: INLINE 'this.js.opener'.
!
outerHeight
	^ Integer fromJs: INLINE 'this.js.outerHeight'.
!
outerWidth
	^ Integer fromJs: INLINE 'this.js.outerWidth'.
!
pageXOffset
	^ self scrollX.
!
pageYOffset
	^ self scrollY.
!
parent
	"Todo: Also implement iFrame result."
	^ Window fromJs: INLINE 'this.js.parent'.
!
personalBarVisible
	^ Boolean fromJs: INLINE 'this.js.personalbar.visible'.
!
screen
	^ Screen fromJs: INLINE 'this.js.screen'.
!
screenLeft
	^ Integer fromJs: INLINE 'this.js.screenLeft'.
!
screenTop
	^ Integer fromJs: INLINE 'this.js.screenTop'.
!
screenX
	^ Integer fromJs: INLINE 'this.js.screenX'.
!
screenY
	^ Integer fromJs: INLINE 'this.js.screenY'.
!
screenPos
	^ self screenX @ self screenY.
!
scrollBarsVisible
	^ Boolean fromJs: INLINE 'this.js.scrollbars.visible'.
!
scrollX
	^ Integer fromJs: INLINE 'Math.round( this.js.scrollX )'.
!
scrollY
	^ Integer fromJs: INLINE 'Math.round( this.js.scrollY )'.
!
self
	^ Window fromJs: INLINE 'this.js.self'.
!
sessionStorage
	^ Storage fromJs: INLINE 'this.js.sessionStorage'.
!
speechSynthesis
	^ SpeechSynthesis fromJs: INLINE 'this.js.speechSynthesis'.
!
statusBarVisible
	^ Boolean fromJs: INLINE 'this.js.statusbar.visible'.
!
toolBarVisible
	^ Boolean fromJs: INLINE 'this.js.toolbar.visible'.
!
top
	^ Window fromJs: INLINE 'this.js.top'.
!
visualViewport
	^ VisualViewport fromJs: INLINE 'this.js.visualViewport'.
!
window
	^ Window fromJs: INLINE 'this.js.window'.
!

"Callback."

requestIdleCallback: callback timeout: timeout
	^ Integer fromJs: INLINE 'this.js.requestIdleCallback( callback.js, { timeout: timeout.js } )'.
!
cancelIdleCallback: handle
	INLINE 'this.js.cancelIdleCallback( handle.js )'.
!

"Animation."

requestAnimationFrame: callback
	INLINE 'this.js.requestAnimationFrame( callback.js )'.
!
cancelAnimationFrame: requestId
	INLINE 'this.js.cancelAnimationFrame( requestId.js )'.
!

"Dialogs."

alert: message
	INLINE 'this.js.alert( message.js )'.
!
confirm: message
	^ Boolean fromJs: INLINE 'this.js.confirm( message.js )'.
!
prompt: message
	^ self prompt: message defaultValue: ''.
!
prompt: message defaultValue: defaultValue
	^ String fromJs: INLINE 'this.js.prompt( message.js, defaultValue.js )'.
!

"Open, move, close."

open: url target: target features: features
	^ Window fromJs: INLINE 'this.js.open( url.js, target.js, features.js )'.
!
moveBy: delta
	INLINE 'this.js.moveBy( delta.x.js, delta.y.js )'.
!
moveTo: point
	INLINE 'this.js.moveTo( point.x.js, point.y.js )'.
!
close
	INLINE 'this.js.close()'.
!

"Other methods."

blur
	INLINE 'this.js.blur()'.
!
focus
	INLINE 'this.js.focus()'.
!
getComputedStyle: element
	^ CssStyleDeclaration fromJs: INLINE 'this.js.getComputedStyle( element.js )'.
!
getSelection
	^ Selection fromJs: INLINE 'this.js.getSelection()'.
!
matchMedia: mediaQueryString
	^ MediaQueryList fromJs: INLINE 'this.js.matchMedia( mediaQueryString.js )'.
!
postMessage: message targetOrigin: targetOrigin
	INLINE 'this.js.postMessage( message.js, targetOrigin.js )'.
!
print
	INLINE 'this.js.print()'.
!
resizeBy: delta
	INLINE 'this.js.resizeBy( delta.x.js, delta.y.js )'.
!
resizeTo: size
	INLINE 'this.js.resizeTo( size.x.js, size.y.js )'.
!
scrollTo: point
	INLINE 'this.js.resizeTo( point.x.js, point.y.js )'.
!
scrollTo: point behavior: behavior
	INLINE 'this.js.scrollTo( { top: point.y.js, left: point.x.js, behavior: behavior.js } )'.
!
scrollBy: point
	INLINE 'this.js.scrollBy( point.x.js, point.y.js )'.
!
scrollBy: point behavior: behavior
	INLINE 'this.js.scrollBy( { top: point.y.js, left: point.x.js, behavior: behavior.js } )'.
!
stop
	INLINE 'this.js.stop()'.
!
