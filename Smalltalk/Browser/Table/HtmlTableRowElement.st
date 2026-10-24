CLASS HtmlTableRowElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Create a new table row element in the default document."
	^ Document default createElement: 'tr'.
!

METHODS

cells
	^ Array fromJs: INLINE 'this.js.cells' elementClass: HtmlTableCellElement.
!
rowIndex
	^ Integer fromJs: INLINE 'this.js.rowIndex'.
!
sectionRowIndex
	^ Integer fromJs: INLINE 'this.js.sectionRowIndex'.
!
insertCell
	 ^ HtmlTableCellElement fromJs: INLINE 'this.js.insertCell()'.
!
insertCell: index
	 ^ HtmlTableCellElement fromJs: INLINE 'this.js.insertCell( index.js )'.
!
deleteCell: index
	 INLINE 'this.js.deleteCell( index.js )'.
!
