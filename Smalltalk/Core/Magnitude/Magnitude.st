CLASS Magnitude EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Abstract base class for classes holding an ordinal value.
	 Instance variable value contains a JS object, it is *not* a ST object.
	 So only pass to methods that expect JS objects, e.g. use INLINE."

METHODS

"Comparisons larger (or equal) use implementation of smaller (or equal) counterparts.
 This saves a lot of boilerplate code."

> magnitude
	^ ( self <= magnitude ) not.
!
>= magnitude
	^ ( self < magnitude ) not.
!
