CLASS MariadbDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements MariaDB database functionality.
Variable 'js' will contain an instance of 'mariadb.Connection'.

Note: The method 'end' should be called when you are done with the database connection
	to free up resources and be able to terminate your app."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as mariadb$ from 'mariadb';"
INLINE 'const mariadb$ = await import( "mariadb" );'

"Connecting"

connect: connectionString then: block catch: errorBlock
	INLINE 'let savedThis = this;
		mariadb$.createConnection( connectionString.js )
			.then( function ( connection ) { savedThis.js = connection ; block.$value() } )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
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

query: query then: block catch: errorBlock
	INLINE 'this.js.query( query.js )
		.then( ( result ) => this.$onQuery$then$( stJsObject$class.$fromJs$( result ), block ) )
		.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
query: query with: parameters then: block catch: errorBlock
	INLINE 'this.js.query( query.js, parameters.$toJs() )
		.then( ( result ) => this.$onQuery$then$( stJsObject$class.$fromJs$( result ), block ) )
		.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
onQuery: result then: block
	"Result is a JsObject containing one of:
		For INSERT, UPDATE, DELETE: a MariadbOkPacket
		For SELECT: a JS array with result JS objects (rows)."

	result jsClassName = 'OkPacket'
		ifTrue: [ result := MariadbOkPacket fromJs: result js ]
		ifFalse: [ result := Object fromJs: result js ].

	block value: result.
!
end
	INLINE 'this.js.end()'.
!
