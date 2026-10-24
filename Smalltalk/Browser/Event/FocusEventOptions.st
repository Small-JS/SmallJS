CLASS FocusEventOptions EXTENDS UiEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a FocusEvent instance."

METHODS

"Events"

relatedTarget
	^ MouseEvent targetFromJs: INLINE 'this.js.relatedTarget'.
!
relatedTarget: relatedTarget
	INLINE 'this.js.relatedTarget = relatedTarget.js'.
!
