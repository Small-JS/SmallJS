CLASS MysqlDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements MySQL database functionality.
Variable 'js' will contain an instance of 'mysql2.Client'.

Note: The method 'end' should be called when you are done with the database connection
	to free up resources and be able to terminate your app."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as mysql$ from 'mysql2';'"
INLINE 'const mysql$ = await import( "mysql2" );'

"Connect / disconnect"

connect: connectionString then: block catch: errorBlock
	MysqlQueryError.    "Force import"
	INLINE '
		this.js = mysql$.createConnection( connectionString.js );
		this.js.connect( ( queryError ) => this.$onConnect$then$catch$(
			stMysqlQueryError$class.$fromJs$( queryError ), block, errorBlock ) )'.
!
onConnect: queryError then: block catch: errorBlock
	queryError notNil ifTrue: [
		^ errorBlock value: queryError ].

	block value.
!
end
	INLINE 'this.js.close()'.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ MysqlTable database: self name: name rowClass: rowClass.
!

"Querying"

query: query then: block catch: errorBlock
	MysqlQueryError.    "Force import"
	INLINE 'this.js.query( query.js, ( error, result ) => this.$onQuery$result$then$catch$(
		stMysqlQueryError$class.$fromJs$( error ), stJsObject$class.$fromJs$( result ), block, errorBlock ) )'.
!
query: query with: parameters then: block catch: errorBlock
	MysqlQueryError.    "Force import"
	INLINE 'this.js.query( query.js, parameters.$toJs(), ( error, result ) => this.$onQuery$result$then$catch$(
		stMysqlQueryError$class.$fromJs$( error ), stJsObject$class.$fromJs$( result ), block, errorBlock ) )'.
!
onQuery: error result: result then: block catch: errorBlock
	"Result is a ST JsObject containing either:
		For INSERT, UPDATE: a JS ResultSetHeader
		For SELECT: a JS array with result rows."

	error notNil ifTrue: [
		^ errorBlock value: error ].

	result jsClassName = 'ResultSetHeader'
		ifTrue: [ result := MysqlResultSetHeader fromJs: result js ]
		ifFalse: [ result := Object fromJs: result js ].

	block value: result.
!
