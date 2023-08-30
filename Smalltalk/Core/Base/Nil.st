CLASS Nil EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"The value instance variable is always JS null, for convenience in calling the JS API.
	 The only 1 instance of Nil is created and used, the JS global stNil."

CLASSMETHODS

fromJs: jsObject
	"Return ST nil if jsObject is null of undefined, otherwise return jsObject."
	^ INLINE 'jsObject == null ? stNil : jsObject'.
!

METHODS

toString
	^ 'nil'.
!
isNil
	^ true.
!
