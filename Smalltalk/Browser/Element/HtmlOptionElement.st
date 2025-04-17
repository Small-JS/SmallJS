CLASS HtmlOptionElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!
text
	^ String fromJs: INLINE 'this.js.text'.
!
text: text
	INLINE 'this.js.text = text.js'.
!
defaultSelected
	^ Boolean fromJs: INLINE 'this.js.defaultSelected'.
!
defaultSelected: defaultSelected
	INLINE 'this.js.defaultSelected = defaultSelected.js'.
!
selected
	^ Boolean fromJs: INLINE 'this.js.selected'.
!
selected: selected
	INLINE 'this.js.selected = selected.js'.
!
