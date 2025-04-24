CLASS HtmlSelectElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

"Properties"

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
length
	^ Integer fromJs: INLINE 'this.js.length'.
!
length: length
	INLINE 'this.js.length = length.js'.
!
size
	^ Integer fromJs: INLINE 'this.js.size'.
!
size: size
	INLINE 'this.js.size = size.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!

"Selection"

selectedIndex
	^ Integer fromJs: INLINE 'this.js.selectedIndex'.
!
selectedIndex: selectedIndex
	INLINE 'this.js.selectedIndex = selectedIndex.js'.
!
selectedOptions
	^ Array fromJs: INLINE 'this.js.selectedOptions' elementClass: HtmlOptionElement.
!
value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!

"Options"

options
	^ Array fromJs: INLINE 'this.js.options' elementClass: HtmlOptionElement.
!
item: index
	^ HtmlOptionElement fromJs: INLINE 'this.js.item( index.js )'.
!
namedItem: string
	^ HtmlOptionElement fromJs: INLINE 'this.js.namedItem( string.js )'.
!
add: option
	INLINE 'this.js.add( option.js )'.
!
remove: index
	INLINE 'this.js.remove( index.js )'.
!

"Settings"

autocomplete
	^ String fromJs: INLINE 'this.js.autocomplete'.
!
autocomplete: autocomplete
	INLINE 'this.js.autocomplete = autocomplete.js'.
!
disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
multiple
	^ Boolean fromJs: INLINE 'this.js.multiple'.
!
multiple: multiple
	INLINE 'this.js.multiple = multiple.js'.
!
required
	^ Boolean fromJs: INLINE 'this.js.required'.
!
required: required
	INLINE 'this.js.required = required.js'.
!

"Related elements"

form
	^ HtmlFormElement fromJs: INLINE 'this.js.form'.
!
labels
	^ Array fromJs: INLINE 'this.js.labels' elementClass: HtmlLabelElement.
!

"Validating"

validationMessage
	^ String fromJs: INLINE 'this.js.validationMessage'.
!
validity
	^ ValidityState fromJs: INLINE 'this.js.validity'.
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
setCustomValidity: string
	INLINE 'this.js.setCustomValidity( string.js )'.
!

"Viewing"

showPicker
	INLINE 'this.js.showPicker()'.
!

"Events"

onChange: block
	self addEventListener: 'change'
		then: [ block value ].
!
