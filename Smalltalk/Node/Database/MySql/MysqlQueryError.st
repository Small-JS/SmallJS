CLASS MysqlQueryError EXTENDS Error MODULE Database CLASSVARS '' VARS ''

code
	^ String fromJs: INLINE 'this.js.code'.
!
sqlStateMarker
	^ String fromJs: INLINE 'this.js.sqlStateMarker'.
!
sqlState
	^ String fromJs: INLINE 'this.js.sqlState'.
!
fieldCount
	^ Integer fromJs: INLINE 'this.js.fieldCount'.
!
fatal
	^ Boolean fromJs: INLINE 'this.js.fatal'.
!
