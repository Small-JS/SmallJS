CLASS HtmlTextAreaElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

"Properties."

accessKey
	^ String fromJs: INLINE 'this.js.accessKey'.
!
accessKey: accessKey
	INLINE 'this.js.accessKey = accessKey.js'.
!
autocapitalize
	^ String fromJs: INLINE 'this.js.autocapitalize'.
!
autocapitalize: autocapitalize
	INLINE 'this.js.autocapitalize = autocapitalize.js'.
!
autofocus
	^ Boolean fromJs: INLINE 'this.js.autofocus'.
!
autofocus: autofocus
	INLINE 'this.js.autofocus = autofocus.js'.
!
cols
	^ Integer fromJs: INLINE 'this.js.cols'.
!
cols: cols
	INLINE 'this.js.cols = cols.js'.
!
defaultValue
	^ String fromJs: INLINE 'this.js.defaultValue'.
!
defaultValue: defaultValue
	INLINE 'this.js.defaultValue = defaultValue.js'.
!
disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
form
	^ HtmlFormElement fromJs: INLINE 'this.js.form'
!
maxLength
	^ Integer fromJs: INLINE 'this.js.maxLength'.
!
maxLength: maxLength
	INLINE 'this.js.maxLength = maxLength.js'.
!
minLength
	^ Integer fromJs: INLINE 'this.js.minLength'.
!
minLength: minLength
	INLINE 'this.js.minLength = minLength.js'.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
placeholder
	^ String fromJs: INLINE 'this.js.placeholder'.
!
placeholder: placeholder
	INLINE 'this.js.placeholder = placeholder.js'.
!
readOnly
	^ Boolean fromJs: INLINE 'this.js.readOnly'.
!
readOnly: readOnly
	INLINE 'this.js.readOnly = readOnly.js'.
!
required
	^ Boolean fromJs: INLINE 'this.js.required'.
!
required: required
	INLINE 'this.js.required = required.js'.
!
rows
	^ String fromJs: INLINE 'this.js.rows'.
!
rows: rows
	INLINE 'this.js.rows = rows.js'.
!
textLength
	^ Integer fromJs: INLINE 'this.js.textLength'.
!
value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!
wrap
	^ String fromJs: INLINE 'this.js.wrap'.
!
wrap: wrap
	INLINE 'this.js.wrap = wrap.js'.
!
labels
	^ Array fromJs: INLINE 'this.js.labels' elementClass: HtmlLabelElement.
!

"Selection"

selectionDirection
	^ String fromJs: INLINE 'this.js.selectionDirection'.
!
selectionDirection: selectionDirection
	INLINE 'this.js.selectionDirection = selectionDirection.js'.
!
selectionStart
	^ Integer fromJs: INLINE 'this.js.selectionStart'.
!
selectionStart: selectionStart
	INLINE 'this.js.selectionStart = selectionStart.js'.
!
selectionEnd
	^ Integer fromJs: INLINE 'this.js.selectionEnd'.
!
selectionEnd: selectionEnd
	INLINE 'this.js.selectionEnd = selectionEnd.js'.
!
blur
	INLINE 'this.js.blur()'.
!
focus
	INLINE 'this.js.focus()'.
!
select
	INLINE 'this.js.select()'.
!
setRangeText: text start: start end: end
	INLINE 'this.js.setRangeText( text.js, start.js, end.js )'.
!
setSelectionRange: start to: end
	INLINE 'this.js.setSelectionRange( start.js, end.js )'.
!

"Validation"

checkValidity
	^ Boolean fromJs: INLINE 'this.js.checkValidity()'.
!
reportValidity
	^ Boolean fromJs: INLINE 'this.js.reportValidity()'.
!
setCustomValidity: validity
	INLINE 'this.js.setCustomValidity( validity.js )'.
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

