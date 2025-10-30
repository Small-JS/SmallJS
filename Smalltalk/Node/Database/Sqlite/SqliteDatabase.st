CLASS SqliteDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements SQLite database functionality.
 Variable 'js' will contain an instance of the JS class sqlite.DatabaseSync.

 Database operations are synchronous.
 There optional wrapper functions with async 'then:' interfaces,
 to be compatible with the other databases from a single code base."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as sqlite$ from 'node:sqlite';'"
INLINE 'const sqlite$ = await import( "node:sqlite" );'

CLASSMETHODS

new: path
	^ self fromJs:
		INLINE 'new sqlite$.DatabaseSync( path.js )'.
!
new: path options: options
	^ self fromJs:
		INLINE 'new sqlite$.DatabaseSync( path.js, options.js )'.
!
checkExists: path
	"Check database at path exists, otherwise throw error."
	( Fs existsSync: path ) ifFalse: [
		Error throw: 'SQLite database file does not exist: ', path ].
!

METHODS

"Opening & closing"

open
	INLINE 'this.js.open()'.
!
connect: path
	self connect: path options: SqliteDatabaseOptions new.
!
connect: path options: options
	"This should be called when the class was created with 'new', wothout a path.
	 The database file must exist and be a valid SQLite database."
	self isNull ifFalse: [
		self error: 'SQLite database already connected.' ].

	SqliteDatabase checkExists: path.
	self js: INLINE 'new sqlite$.DatabaseSync( path.js, options.js )'.
	self checkValid.
!
checkValid
	"Check if the file opened is a valid SQLite database, otherwise throw an error."
	self exec: 'PRAGMA quick_check'.
!
close
	INLINE 'this.js.close()'.
!
end
	"Compatibility method."
	self close.
!

"SQL statements"

exec: sql
	INLINE 'this.js.exec( sql.js )'.
!
prepare: sql
	^ SqliteStatement fromJs: INLINE 'this.js.prepare( sql.js )'.
!

"Common SQL interface"

query: query
	self query: query with: #().
!
query: query with: parameters
	| statement |
	statement := self prepare: query.
	^ statement all: parameters.
!

"Table"

connectTable: name rowClass: rowClass
	"Create a table connection within this database."
	^ SqliteTable database: self name: name rowClass: rowClass.
!

"Extensions"

enableLoadExtension: boolean
	INLINE 'this.js.enableLoadExtension( boolean.js )'.
!
loadExtension: path
	INLINE 'this.js.loadExtension( path.js )'.
!

