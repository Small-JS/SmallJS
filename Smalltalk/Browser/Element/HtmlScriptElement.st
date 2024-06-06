CLASS HtmlScriptElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class HTMLScriptElement,
	 of which variable js contains an instance."

CLASSMETHODS

supports: type
	^ Boolean fromJs: INLINE 'HTMLScriptElement.supports( type.js )'.
!

METHODS

"Properties."

type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
src
	^ String fromJs: INLINE 'this.js.src'.
!
src: src
	INLINE 'this.js.src = src.js'.
!
isAsync
	^ Boolean fromJs: INLINE 'this.js.async'.
!
isAsync: async
	INLINE 'this.js.async = async.js'.
!
defer
	^ Boolean fromJs: INLINE 'this.js.defer'.
!
defer: defer
	INLINE 'this.js.defer = defer.js'.
!
crossOrigin
	^ String fromJs: INLINE 'this.js.crossOrigin'.
!
crossOrigin: crossOrigin
	INLINE 'this.js.crossOrigin = crossOrigin.js'.
!
text
	^ String fromJs: INLINE 'this.js.text'.
!
text: text
	INLINE 'this.js.text = text.js'.
!
referrerPolicy
	^ String fromJs: INLINE 'this.js.referrerPolicy'.
!
referrerPolicy: referrerPolicy
	INLINE 'this.js.referrerPolicy = referrerPolicy.js'.
!

