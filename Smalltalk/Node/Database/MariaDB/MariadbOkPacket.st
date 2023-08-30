CLASS MariadbOkPacket EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''

affectedRows
	^ Integer fromJs: INLINE 'this.js.affectedRows'.
!
insertId
	^ BigInt fromJs: INLINE 'this.js.insertId'.
!
warningStatus
	^ Integer fromJs: INLINE 'this.js.warningStatus'.
!

