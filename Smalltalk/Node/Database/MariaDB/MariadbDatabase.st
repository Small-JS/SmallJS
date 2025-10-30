CLASS MariadbDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements MariaDB database functionality.
Variable 'js' will contain an instance of 'mariadb.Connection'.

Note: The method 'end' should be called when you are done with the database connection
	to free up resources and be able to terminate your app."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as mariadb$ from 'mariadb';"
INLINE 'const mariadb$ = await import( "mariadb" );'

"Connecting"

async connect: connectionString
	self js: INLINE 'await mariadb$.createConnection( connectionString.js )'.
!

"Properties"

threadId
	self isUndefined ifTrue: [ ^ nil ].
	^ Integer fromJs: INLINE 'this.js.info.threadId'.
!
status
	self isUndefined ifTrue: [ ^ nil ].
	^ Integer fromJs: INLINE 'this.js.info.status'.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ MariadbTable database: self name: name rowClass: rowClass.
!

"Querying"

async query: query
	^ self onQuery: (
		JsObject fromJs: INLINE 'await this.js.query( query.js )' ).
!
async query: query with: parameters
	^ self onQuery: (
		JsObject fromJs: INLINE 'await this.js.query( query.js, parameters.$toJs() )' ).
!
onQuery: result
	"Result is a JsObject containing one of:
		For INSERT, UPDATE, DELETE: a MariadbQueryResult (JS 'OkPacket')
		For SELECT: a JS array with result JS objects (rows)."

	^ result jsClassName = 'OkPacket'
		ifTrue: [ MariadbQueryResult fromJs: result js ]
		ifFalse: [ Object fromJs: result js ].
!
async end
	INLINE 'await this.js.end()'.
!
