CLASS SqliteStatementResultingChanges EXTENDS JsObject MODULE DatabaseSqlite CLASSVARS '' VARS ''

changes
	^ Integer fromJs: INLINE 'this.js.changes'.
!
lastInsertRowId
	^ Integer fromJs: INLINE 'this.js.lastInsertRowid'.
!
