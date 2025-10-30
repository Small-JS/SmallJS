CLASS SqliteStatement EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''

"Executing"

all: parameters
	^ Object fromJs:
		INLINE 'this.js.all( ...parameters.$toJs() )'.
!
run: parameters
	^ SqliteStatementResultingChanges fromJs:
		INLINE 'this.js.run( ...parameters.$toJs() )'.
!

"Inspecting"

expandedSql
	^ String fromJs: INLINE 'this.js.expandedSQL()'.
!
sourceSql
	^ String fromJs: INLINE 'this.js.sourceSQL()'.
!

