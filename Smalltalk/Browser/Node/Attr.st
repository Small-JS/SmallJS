CLASS Attr EXTENDS Node MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS 'Attr' class."

METHODS

"Properties."

localName
	^ String fromJs: INLINE 'this.js.localName'.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
ownerElement
	^ Element fromJsSubElement: INLINE 'this.js.ownerElement'.
!
value
	^ String fromJs: INLINE 'this.js.value'.
!
value: aValue
	INLINE 'this.js.value = aValue.js'.
!
