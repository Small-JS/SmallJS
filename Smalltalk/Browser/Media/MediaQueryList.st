CLASS MediaQueryList EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class: MediaQueryList.
	 Get it with: Window matchMedia: mediaQueryString."

METHODS

"Properties"

matches
	"Return true if the document currently matches the media query."
	^ Boolean fromJs: INLINE 'this.js.matches'.
!
media
	"Return the serialized media query String."
	^ String fromJs: INLINE 'this.js.media'.
!

"Events"

onChange: block
	"Block is called with a MediaQueryListEvent when the result of the media query changes."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( MediaQueryListEvent fromJs: jsEvent ) ].
	INLINE 'this.js.onchange = jsBlock.js'.
!
