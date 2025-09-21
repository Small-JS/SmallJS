CLASS PostgresDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements Postgres database functionality.
 Variable 'js' will contain an instance of 'pg.Client'.

 Note: The method 'end' should be called when you are done with the database connection
 	   to free up resources and be able to terminate your app."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as pg$ from 'pg';'"
INLINE 'const pg$ = await import( "pg" );'

"Connect / disconnect"

connect: connectionString then: block catch: errorBlock
	INLINE 'this.js = new pg$.Client( connectionString.js )'.
	INLINE 'this.js.connect()
		.then( () => block.$value() )
		.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
end
	INLINE 'this.js.end()'.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ PostgresTable database: self name: name rowClass: rowClass.
!

"Querying"

query: query then: block catch: errorBlock
	"Force reference to prevent minimizing."
	PostgresQueryResult.
	INLINE 'this.js.query( query.js )
		.then( ( queryResult ) => block.$value$( stPostgresQueryResult$class.$fromJs$( queryResult ) ) )
		.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
query: query with: parameters then: block catch: errorBlock
	"Force reference to prevent minimizing."
	PostgresQueryResult.
	INLINE 'this.js.query( query.js, parameters.$toJs() )
		.then( ( queryResult ) => block.$value$( stPostgresQueryResult$class.$fromJs$( queryResult ) ) )
		.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
