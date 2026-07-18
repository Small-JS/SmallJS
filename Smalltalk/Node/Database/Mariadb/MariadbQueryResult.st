CLASS MariadbQueryResult EXTENDS JsObject MODULE DatabaseMariadb CLASSVARS '' VARS ''

"Implements Mariadb JS class: OkPacket"

affectedRows
	^ Integer fromJs: INLINE 'this.js.affectedRows'.
!
insertId
	^ BigInt fromJs: INLINE 'this.js.insertId'.
!
warningStatus
	^ Integer fromJs: INLINE 'this.js.warningStatus'.
!
