CLASS HtmlButtonElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

autofocus
	^ Boolean fromJs: INLINE 'this.js.autofocus'.
!
autofocus: autofocus
	INLINE 'this.js.autofocus = autofocus.js'.
!
disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
form
	^ HtmlFormElement fromJs: INLINE 'this.js.form'.
!
formAction
	^ String fromJs: INLINE 'this.js.formAction'.
!
formAction: formAction
	INLINE 'this.js.formAction = formAction.js'.
!
formEnctype
	^ String fromJs: INLINE 'this.js.formEnctype'.
!
formEnctype: formEnctype
	INLINE 'this.js.formEnctype = formEnctype.js'.
!
formMethod
	^ String fromJs: INLINE 'this.js.formMethod'.
!
formMethod: formMethod
	INLINE 'this.js.formMethod = formMethod.js'.
!
formNoValidate
	^ Boolean fromJs: INLINE 'this.js.formNoValidate'.
!
formNoValidate: formNoValidate
	INLINE 'this.js.formNoValidate = formNoValidate.js'.
!
formTarget
	^ String fromJs: INLINE 'this.js.formTarget'.
!
formTarget: formTarget
	INLINE 'this.js.formTarget = formTarget.js'.
!
labels
	^ Array fromJs: INLINE' this.js.labels' elementClass: HtmlLabelElement.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
willValidate
	^ Boolean fromJs: INLINE 'this.js.willValidate'.
!
validationMessage
	^ String fromJs: INLINE 'this.js.validationMessage'.
!
valid
	^ Boolean fromJs: INLINE 'this.js.validity.valid'.
!
value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!
