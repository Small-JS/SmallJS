CLASS PostgresDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''
	"This class implements Postgres database functionality.
	 Variable 'js' will contain an instance of 'pg.Client'.

	 Note: The method 'end' should be called when you are done with the database connection
	 	   to free up resources and be able to terminate your app."

INLINE 'import pg from "pg";'

METHODS

references
	"Force import of classes that are referenced in INLINE statements."

	PostgresQueryResult.
!

"Connecting"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ PostgresTable database: self name: name rowClass: rowClass.
!

"Operations"

connect: connectionString then: block
	INLINE 'this.js = new pg.Client( connectionString.js )'.
	INLINE 'this.js.connect().then( () => block.$value() )'.
!
query: query then: block
	INLINE 'this.js.query( query.js ).
		then( ( result ) => block.$value$( stPostgresQueryResult$class.$fromJs$( result ) ) )'.
!
query: query with: parameters then: block
	INLINE 'this.js.query( query.js, parameters.$toJs() ).
		then( ( result ) => block.$value$( stPostgresQueryResult$class.$fromJs$( result ) ) )'.
!
end
	INLINE 'this.js.end()'.
!
