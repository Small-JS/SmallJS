CLASS QGridLayout EXTENDS QLayout MODULE NodeGui CLASSVARS '' VARS ''

"Arranges widgets in a grid of rows and columns. Row and column indexes are 0-based.
 Note: NodeGui does not implement count for QGridLayout."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QGridLayout()'.
!

METHODS

addWidget: widget row: row column: column
	INLINE 'this.js.addWidget( widget.js, row.js, column.js )'.
!
addWidget: widget row: row column: column align: align
	INLINE 'this.js.addWidget( widget.js, row.js, column.js, 1, 1, align.js )'.
!
rowCount
	^ Integer fromJs: INLINE 'this.js.rowCount()'.
!
columnCount
	^ Integer fromJs: INLINE 'this.js.columnCount()'.
!
setColumnMinimumWidth: column to: width
	INLINE 'this.js.setColumnMinimumWidth( column.js, width.js )'.
!
columnMinimumWidth: column
	^ Integer fromJs: INLINE 'this.js.columnMinimumWidth( column.js )'.
!
