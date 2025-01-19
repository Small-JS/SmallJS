CLASS SqliteDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements SQLite database functionality.
 Variable 'js' will contain an instance of the JS class DatabaseSync.

 Database operations are synchronous.
 There optional wrapper functions with async 'then:' interfaces,
 to be compatible with the other databases from a single code base."

INLINE 'import { DatabaseSync } from "node:sqlite";'

CLASSMETHODS

new: path
	^ self fromJs: INLINE 'new DatabaseSync( path.js )'.
!
new: path options: options
	^ self fromJs: INLINE 'new DatabaseSync( path.js, options.js )'.
!
checkExists: path
	"Check database at path exists, otherwise throw error."
	( Fs existsSync: path ) ifFalse: [
		Error throw: 'SQLite database file does not exist: ', path ].
!

METHODS

"================================== Sync operations"

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
	self js: INLINE 'new DatabaseSync( path.js, options.js )'.
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

"================================== Async operations"

"Connecting"

connect: path then: block catch: errorBlock
	[ self connect: path. block value ]
		tryCatch: [ :error | errorBlock value: error ].
!

"SQL statements"

query: query then: block catch: errorBlock
	self query: query with: #() then: block catch: errorBlock.
!
query: query with: parameters then: block catch: errorBlock
	| statement |
	statement := self prepare: query.
	[ block value: ( statement all: parameters ) ]
		tryCatch: [ :error | errorBlock value: error ].
!
