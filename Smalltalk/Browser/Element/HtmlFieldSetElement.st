CLASS HtmlFieldSetElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

METHODS

"Properties"

disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
elements
	^ Array fromJs: INLINE 'this.js.elements' elementConverter:
		[ :element | Element fromJsSubElement: element ].
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
validationMessage
	^ String fromJs: INLINE 'this.js.validationMessage'.
!
validity
	^ ValidityState fromJs: INLINE 'this.js.validity'.
!
willValidate
	^ Boolean fromJs: INLINE 'this.js.willValidate'.
!

"Methods"

checkValidity
	^ Boolean fromJs: INLINE 'this.js.checkValidity()'.
!
reportValidity
	^ Boolean fromJs: INLINE 'this.js.reportValidity()'.
!
setCustomValidity: customValidityMessage
	INLINE 'this.js.setCustomValidity( customValidityMessage.js )'.
!
