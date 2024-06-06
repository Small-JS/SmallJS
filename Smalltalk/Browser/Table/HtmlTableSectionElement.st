CLASS HtmlTableSectionElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

METHODS

"Properties"

rows
	^ Array fromJs: INLINE 'this.js.rows' elementClass: HtmlTableRowElement.
!
deleteRow: index
	INLINE 'this.js.deleteRow( index.js )'.
!
insertRow: index
	^  HtmlTableRowElement fromJs: INLINE 'this.js.insertRow( index.js )'.
!
