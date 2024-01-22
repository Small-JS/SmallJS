CLASS MysqlDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''
	"This class implements MySQL database functionality.
	 Variable 'js' will contain an instance of 'my.Client'.

	 Note: The method 'end' should be called when you are done with the database connection
	 	   to free up resources and be able to terminate your app."

INLINE 'import * as MySql from "mysql2";'

METHODS

references
	"Force import of classes that are referenced in INLINE statements."

	MysqlQueryError.
!

"Connecting"

async connect: connectionString then: block
	INLINE '
		this.js = MySql.createConnection( connectionString.js );
		this.js.connect( ( queryError ) => this.$onConnect$then$( stMysqlQueryError$class.$fromJs$( queryError ), block ) )'.
!
onConnect: queryError then: block
	queryError notNil ifTrue: [
		self error: 'Database connection failed: ', queryError message ].

	block value.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ MysqlTable database: self name: name rowClass: rowClass.
!

"Querying"

query: query then: block
	INLINE 'this.js.query( query.js, ( error, result ) => this.$onQuery$result$then$(
		stMysqlQueryError$class.$fromJs$( error ), stJsObject$class.$fromJs$( result ), block ) )'.
!
query: query with: parameters then: block
	INLINE 'this.js.query( query.js, parameters.$toJs(), ( error, result ) => this.$onQuery$result$then$(
		stMysqlQueryError$class.$fromJs$( error ), stJsObject$class.$fromJs$( result ), block ) )'.
!
onQuery: error result: result then: block
	"Result is a ST JsObject containing either:
		For INSERT, UPDATE: a JS ResultSetHeader
		For SELECT: a JS array with result rows."

	error notNil ifTrue: [
		self error: 'Query failed: ', error message ].

	result jsClassName = 'ResultSetHeader'
		ifTrue: [ result := MysqlResultSetHeader fromJs: result js ]
		ifFalse: [ result := Object fromJs: result js ].

	block value: result.
!
end
	INLINE 'this.js.close()'.
!
