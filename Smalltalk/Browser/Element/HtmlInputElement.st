CLASS HtmlInputElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

"Properties related to the parent form."

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
formEncType: formEnctype
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
	INLINE 'this.js.formtarget = formTarget.js'.
!

"Not hidden"

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
disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
autofocus
	^ Boolean fromJs: INLINE 'this.js.autofocus'.
!
autofocus: autofocus
	INLINE 'this.js.autofocus = autofocus.js'.
!
value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!
valueAsDate
	^ Date fromJs: INLINE 'this.js.valueAsDate'.
!
valueAsNumber
	"Note: this method converts date/time elements to numbers.
	 It does *not* convert integers or floats to numbers.
	 See: https://stackoverflow.com/questions/18062069/why-does-valueasnumber-return-nan-as-a-value"
	^ Integer fromJs: INLINE 'this.js.valueAsNumber'.
!

"Validation"

validity
	^ Boolean fromJs: INLINE 'this.js.validity'.
!
validationMessage
	^ String fromJs: INLINE 'this.js.validationMessage'.
!
willValidate
	^ Boolean fromJs: INLINE 'this.js.willValidate'.
!
checkValidity
	^ Boolean fromJs: INLINE 'this.js.checkValidity()'.
!
reportValidity
	^ Boolean fromJs: INLINE 'this.js.reportValidity()'.
!
setCustomValidity: message
	INLINE 'this.js.setCustomValidity( message.js )'.
!

"Checkbox or radio input"

checked
	^ Boolean fromJs: INLINE 'this.js.checked'.
!
checked: checked
	INLINE 'this.js.checked = checked.js'.
!
defaultChecked
	^ Boolean fromJs: INLINE 'this.js.defaultChecked'.
!
defaultChecked: defaultChecked
	INLINE 'this.js.defaultChecked = defaultChecked.js'.
!
indeterminate
	^ Boolean fromJs: INLINE 'this.js.indeterminate'.
!

"Image input"

alt
	^ String fromJs: INLINE 'this.js.alt'.
!
alt: alt
	INLINE 'this.js.alt = alt.js'.
!
width
	^ Integer fromJs: INLINE 'this.js.width'.
!
width: width
	INLINE 'this.js.width = width.js'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
height: height
	INLINE 'this.js.height = height.js'.
!
imageSize
	^ self width @ self height.
!
imageSize: imageSize
	self width: imageSize x.
	self height: imageSize y.
!
src
	^ String fromJs: INLINE 'this.js.src'.
!
src: src
	INLINE 'this.js.src  = src.js'.
!

"File input."

accept
	^ String fromJs: INLINE 'this.js.accept'.
!
accept: accept
	INLINE 'this.js.accept = accept.js'.
!
files
	^ Array fromJs: INLINE 'Array.from( this.js.files )' elementClass: File.
!

"Text and Number input."

autocomplete
	^ String fromJs: INLINE 'this.js.autocomplete'.
!
autocomplete: autocomplete
	INLINE 'this.js.autocomplete = autocomplete.js'.
!
min
	^ String fromJs: INLINE 'this.js.min'.
!
min: min
	INLINE 'this.js.min = min.js'.
!
max
	^ String fromJs: INLINE 'this.js.max'.
!
max: max
	INLINE 'this.js.max = max.js'.
!
minLength
	^ Integer fromJs: INLINE 'this.js.minLength'.
!
minLength: minLength
	INLINE 'this.js.minLength = minLength.js'.
!
maxLength
	^ Integer fromJs: INLINE 'this.js.maxLength'.
!
maxLength: maxLength
	INLINE 'this.js.maxLength = maxLength.js'.
!
pattern
	^ String fromJs: INLINE 'this.js.pattern'.
!
pattern: pattern
	INLINE 'this.js.pattern = pattern.js'.
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
size
	^ Integer fromJs: INLINE 'this.js.size'.
!
size: size
	INLINE 'this.js.size = size.js'.
!
stepUp: increment
	INLINE 'this.js.stepUp( increment.js )'.
!
stepDown: decrement
	INLINE 'this.js.stepDown( decrement.js )'.
!
setRangeText: text start: start end: end selectMode: selectMode
	INLINE 'this.js.setRangeText( text.js, start.js, end.js, selectMode.js )'.
!

"Date input"

showPicker
	INLINE 'this.js.showPicker()'.
!

"Selection"

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
selectionDirection
	^ String fromJs: INLINE 'this.js.selectionDirection'.
!
selectionDirection: selectionDirection
	INLINE 'this.js.selectionDirection = selectionDirection.js'.
!
select
	INLINE 'this.js.select()'.
!
setSelectionRange: start to: end
	INLINE 'this.js.setSelectionRange( start.js, end.js )'.
!

"Properties not yet categorized."

defaultValue
	^ String fromJs: INLINE 'this.js.defaultValue'.
!
defaultValue: defaultValue
	INLINE 'this.js.defaultValue = defaultValue.js'.
!
dirName
	^ String fromJs: INLINE 'this.js.dirName'.
!
dirName: dirName
	INLINE 'this.js.dirName = dirName.js'.
!
accessKey
	^ String fromJs: INLINE 'this.js.accessKey'.
!
accessKey: accessKey
	INLINE 'this.js.accessKey = accessKey.js'.
!
multiple
	^ Boolean fromJs: INLINE 'this.js.multiple'.
!
multiple: multiple
	INLINE 'this.js.multiple = multiple.js'.
!
labels
	^ Array fromJs: INLINE 'this.js.labels' toClass: HtmlLabelElement.
!
