CLASS HtmlOptionElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
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
