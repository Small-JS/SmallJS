CLASS PostgresDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements Postgres database functionality.
 Variable 'js' will contain an instance of 'pg.Client'.

 Note: The method 'end' should be called when you are done with the database connection
 	   to free up resources and be able to terminate your app."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as pg$ from 'pg';'"
INLINE 'const pg$ = await import( "pg" );'

"Connect / disconnect"

async connect: connectionString
	INLINE '
		this.js = new pg$.Client( connectionString.js );
		await this.js.connect()'.
!
async end
	INLINE 'await this.js.end()'.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ PostgresTable database: self name: name rowClass: rowClass.
!

"Querying"

async query: query
	^ PostgresQueryResult fromJs:
		INLINE 'await this.js.query( query.js )'.
!
async query: query with: parameters
	^ PostgresQueryResult fromJs:
		INLINE 'await this.js.query( query.js, parameters.$toJs() )'.
!
