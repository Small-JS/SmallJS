CLASS ShadowRoot EXTENDS DocumentFragment MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS ShadowRoot class."

METHODS

"Properties."

activeElement
	^ HtmlElement fromJsSubElement: INLINE 'this.js.activeElement'.
!
adoptedStyleSheets
	^ Array fromJs: INLINE 'this.js.adoptedStyleSheets' elementClass: CssStyleSheet.
!
delegatesFocus
	^ Boolean fromJs: INLINE 'this.js.delegatesFocus'.
!
fullscreenElement
	^ Element fromJsSubElement: INLINE 'this.js.fullscreenElement'.
!
host
	^ Element fromJsSubElement: INLINE 'this.js.host'.
!
innerHtml
	^ String fromJs: INLINE 'this.js.innerHTML'.
!
mode
	^ String fromJs: INLINE 'this.js.mode'.
!
pointerLockElement
	^ Element fromJsSubElement: INLINE 'this.js.pointerLockElement'.
!
styleSheets
	^ Array fromJs: INLINE 'this.js.styleSheets' elementClass: CssStyleSheet.
!

"Methods."

getAnimations
	^ Array fromJs: INLINE 'this.js.getAnimations()' elementClass: Animation.
!
elementFromPoint: point
	^ Element fromJsSubElement: INLINE 'this.js.elementFromPoint( point.x.js, point.y.js )'.
!
elementsFromPoint: point
	^ Element fromJsSubElements: INLINE 'this.js.elementsFromPoint( point.x.js, point.y.js )'.
!
