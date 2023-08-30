CLASS HtmlTableCellElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new HTMLTableCellElement()'.
!

METHODS

"Properties"

abbr
	^ String fromJs: INLINE 'this.js.abbr'.
!
abbr: abbr
	INLINE 'this.js.abbr = abbr.js'.
!
cellIndex
	^ Integer fromJs: INLINE 'this.js.cellIndex'.
!
headers
	^ String fromJs: INLINE 'this.js.headers'.
!
headers: headers
	INLINE 'this.js.headers = headers.js'.
!
scope
	^ String fromJs: INLINE 'this.js.scope'.
!
scope: scope
	INLINE 'this.js.scope = scope.js'.
!

"Span"

rowSpan
	^ Integer fromJs: INLINE 'this.js.rowSpan'.
!
rowSpan: rowSpan
	INLINE 'this.js.rowSpan = rowSpan.js'.
!
colSpan
	^ Integer fromJs: INLINE 'this.js.colSpan'.
!
colSpan: colSpan
	INLINE 'this.js.colSpan = colSpan.js'.
!
