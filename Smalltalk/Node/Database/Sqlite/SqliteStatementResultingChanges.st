CLASS SqliteStatementResultingChanges EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''

METHODS

changes
	^ Integer fromJs: INLINE 'this.js.changes'.
!
lastInsertRowId
	^ Integer fromJs: INLINE 'this.js.lastInsertRowid'.
!