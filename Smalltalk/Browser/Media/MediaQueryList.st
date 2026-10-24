CLASS MediaQueryList EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: MediaQueryList.
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

eventFromJs: jsEvent
	"Create ST MediaQueryListEvent from JS MediaQueryListEvent, else the ST Event subclass."
	( Boolean fromJs: INLINE 'jsEvent instanceof MediaQueryListEvent' ) ifTrue: [
		^ MediaQueryListEvent fromJs: jsEvent ].
	^ Event fromJsSubEvent: jsEvent.
!
addEventListener: type then: block
	"Override to pass change events as ST MediaQueryListEvent to the block.
	 Block should have 1 argument: the ST Event."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( self eventFromJs: jsEvent ) ].
	INLINE 'this.js.addEventListener( type.js, jsBlock.js )'.
	self eventIds add: ( EventId fromType: type block: block jsBlock: jsBlock ).
!
onChange: block
	"Block is called with a MediaQueryListEvent when the result of the media query changes."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( self eventFromJs: jsEvent ) ].
	INLINE 'this.js.onchange = jsBlock.js'.
!
