CLASS HtmlSelectElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

METHODS

"Properties"

length
	^ String fromJs: INLINE 'this.js.length'.
!
length: length
	INLINE 'this.js.length = length.js'.
!
selectedIndex
	^ Integer fromJs: INLINE 'this.js.selectedIndex'.
!
selectedIndex: selectedIndex
	INLINE 'this.js.selectedIndex = selectedIndex.js'.
!
selectedOptions
	^ Array fromJs: INLINE 'this.js.selectedOptions' elementClass: HtmlOptionElement.
!
selectedText
	"Answer the text of the first selected item
	 or nil if there is no selection."
	| options |
	options := self selectedOptions.
	options length > 0 ifFalse: [ ^ nil ].
	^ options first text.
!

"Methods"

add: option
	INLINE 'this.js.add( option.js )'.
!
