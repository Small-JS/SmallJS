CLASS MysqlResultSetHeader EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''
	"This class implements MySQL ResultSetHeader."

affectedRows
	^ Integer fromJs: INLINE 'this.js.affectedRows'.
!
fieldCount
	^ Integer fromJs: INLINE 'this.js.fieldCount'.
!
info
	^ String fromJs: INLINE 'this.js.info'.
!
insertId
	^ Integer fromJs: INLINE 'this.js.insertId'.
!
serverStatus
	^ Integer fromJs: INLINE 'this.js.serverStatus'.
!
warningStatus
	^ Integer fromJs: INLINE 'this.js.warningStatus'.
!
changedRows
	^ Integer fromJs: INLINE 'this.js.changedRows'.
!
