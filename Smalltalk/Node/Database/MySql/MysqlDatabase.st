CLASS MysqlDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements MySQL database functionality.
Variable 'js' will contain an instance of 'mysql2.Client'.

Note: The method 'end' should be called when you are done with the database connection
	to free up resources and be able to terminate your app."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as mysql$ from 'mysql2';'"
INLINE 'const mysql$ = await import( "mysql2/promise" );'

"Connect / disconnect"

async connect: connectionString
	self js:
		INLINE 'await mysql$.createConnection( connectionString.js )'.
!
async end
	INLINE 'await this.js.close()'.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ MysqlTable database: self name: name rowClass: rowClass.
!

"Querying"

async query: query
	| jsResult |
	INLINE '[ jsResult ] = await this.js.query( query.js )'.
	^ self onQuery: ( JsObject fromJs: jsResult ).
!
async query: query with: parameters
	| jsResult |
	INLINE '[ jsResult ] = await this.js.query( query.js, parameters.$toJs() )'.
	^ self onQuery: ( JsObject fromJs: jsResult ).
!
onQuery: result
	"result is a JsObject containing either:
		For INSERT, UPDATE, DELETE: a JS ResultSetHeader
		For SELECT: a JS array with result rows."

	^ result jsClassName = 'ResultSetHeader'
		ifTrue: [ MysqlResultSetHeader fromJs: result js ]
		ifFalse: [ Object fromJs: result js ].
!
