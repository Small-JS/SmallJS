CLASS SqliteDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements SQLite database functionality.
 Variable 'js' will contain an instance of the JS class DatabaseSync.

 Database operations are synchronous.
 There optional wrapper functions with async 'then:' interfaces,
 to be compatible with the other databases from a single code base.

 2025-01-02: To enable SQLite support in node.js, it be started with '--experimental-sqlite'."

INLINE 'import { DatabaseSync } from "node:sqlite";'

CLASSMETHODS

new: path
	^ self fromJs: INLINE 'new DatabaseSync( path.js )'.
!
new: path options: options
	^ self fromJs: INLINE 'new DatabaseSync( path.js, options.js )'.
!

METHODS

"Opening & closing"

open
	INLINE 'this.js.open()'.
!
connect: path
	"Alias for open, for compatibility with other databases.
	 The database should already already been created with 'new:' and the path."
	self open.
!
connect: path then: block
	"Async compatibility method that is executed sync."
	self connect: path.
	block value.
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
query: query then: block
	"Async compatibility method that is executed sync."

	self query: query with: #() then: block.
!
query: query with: parameters then: block
	"Async compatibility method that is executed sync."

	| statement results |
	statement := self prepare: query.
	results := statement all.
	block value: results.
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

