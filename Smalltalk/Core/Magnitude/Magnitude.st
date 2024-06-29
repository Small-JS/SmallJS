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
compare: magnitude
	"Returns -1, 0 or if self is respectively smaller than, equal to or larger than aMagnitude."
	^ self < magnitude
		ifTrue: [ -1 ]
		ifFalse: [
			self > magnitude
				ifTrue: [ 1 ]
				ifFalse: [ 0 ] ].
!
min: magnitude
	^ self <= magnitude ifTrue: [ self ] ifFalse: [ magnitude ].
!
max: magnitude
	^ self >= magnitude ifTrue: [ self ] ifFalse: [ magnitude ].
!
