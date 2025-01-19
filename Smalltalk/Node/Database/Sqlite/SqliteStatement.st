CLASS SqliteStatement EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''

INLINE 'import { StatementSync } from "node:sqlite";'

"================================== Sync operations"

"Executing"

all: parameters
	^ Object fromJs: INLINE 'this.js.all( ...parameters.$toJs() )'.
!
run: parameters
	^ SqliteStatementResultingChanges fromJs: INLINE 'this.js.run( ...parameters.$toJs() )'.
!

"Inspecting"

expandedSql
	^ String fromJs: INLINE 'this.js.expandedSQL()'.
!
sourceSql
	^ String fromJs: INLINE 'this.js.sourceSQL()'.
!

"================================== Async operations"

"Executing"

all: parameters then: block catch: errorBlock
	[ block value: ( self all: parameters )  ]
		tryCatch: [ :error | errorBlock value: error ].
!
run: parameters then: block catch: errorBlock
	[ block value: ( self run: parameters )  ]
		tryCatch: [ :error | errorBlock value: error ].
!
