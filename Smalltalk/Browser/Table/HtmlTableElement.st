CLASS HtmlTableElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new HTMLTableElement()'.
!

METHODS

"Caption"

caption
	^ String fromJs: INLINE 'this.js.caption'.
!
createCaption
	^ HtmlTableCaptionElement fromJs: INLINE 'this.js.createCaption()'.
!
deleteCaption
	INLINE 'this.js.deleteCaption()'.
!

"Head"

tHead
	^ HtmlTableSectionElement fromJs: INLINE 'this.js.tHead'.
!
createTHead
	^ HtmlTableSectionElement fromJs: INLINE 'this.js.createTHead()'.
!
deleteTHead
	INLINE 'this.js.deleteTHead()'.
!

"Body"

createTBody
	^ HtmlTableSectionElement fromJs: INLINE 'this.js.createTBody()'.
!
tBodies
	^ Array fromJs: INLINE 'this.js.tBodies' elementClass: HtmlTableSectionElement.
!
tBody
	^ self tBodies first.
!

"Rows"

rows
	^ Array fromJs: INLINE 'this.js.rows' elementClass: HtmlTableRowElement.
!
insertRow
	^ HtmlTableRowElement fromJs: INLINE 'this.js.insertRow()'.
!
insertRow: index
	^ HtmlTableRowElement fromJs: INLINE 'this.js.insertRow( index.js )'.
!
deleteRow: index
	INLINE 'this.js.deleteRow( index.js )'.
!

"Foot"

tFoot
	^ HtmlTableSectionElement fromJs: INLINE 'this.js.tFoot'.
!
createTFoot
	^ HtmlTableSectionElement fromJs: INLINE 'this.js.createTFoot()'.
!
deleteTFoot
	INLINE 'this.js.deleteTFoot()'.
!
