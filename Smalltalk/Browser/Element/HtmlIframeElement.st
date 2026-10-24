CLASS HtmlIframeElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

"Size"

width
	"A string, like: '300' or '50%'."
	^ String fromJs: INLINE 'this.js.width'.
!
height
	"A string, like: '150' or '50%'."
	^ String fromJs: INLINE 'this.js.height'.
!
size
	"Return the size in pixels as a Point. An empty width or height is 0.
	 Note: Use width and height to get sizes in other units, like percentages."
	^ ( Integer fromJs: INLINE 'this.js.width' ) @ ( Integer fromJs: INLINE 'this.js.height' ).
!

"Other properties"

allow
		^ String fromJs: INLINE 'this.js.allow'.
!
allow: allow
		INLINE 'this.js.allow = allow.js'.
!
contentDocument
		^ Document fromJs: INLINE 'this.js.contentDocument'.
!
contentWindow
		^ Window fromJs: INLINE 'this.js.contentWindow'.
!
name
		^ String fromJs: INLINE 'this.js.name'.
!
name: name
		INLINE 'this.js.name = name.js'.
!
referrerPolicy
		^ String fromJs: INLINE 'this.js.referrerPolicy'.
!
referrerPolicy: referrerPolicy
		INLINE 'this.js.referrerPolicy = referrerPolicy.js'.
!
sandbox
		^ DomTokenList fromJs: INLINE 'this.js.sandbox'.
!
sandbox: sandbox
		INLINE 'this.js.sandbox = sandbox.js'.
!
src
		^ String fromJs: INLINE 'this.js.src'.
!
src: src
		INLINE 'this.js.src = src.js'.
!
srcDoc
		^ String fromJs: INLINE 'this.js.srcdoc'.
!
srcDoc: srcDoc
		INLINE 'this.js.srcdoc = srcDoc.js'.
!
