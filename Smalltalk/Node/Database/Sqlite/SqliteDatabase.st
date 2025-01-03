CLASS SqliteDatabase EXTENDS SqlDatabase MODULE Database CLASSVARS '' VARS ''

"This class implements SQLite DatabaseSync functionality.
 Variable 'js' will contain an instance of the JS class Database.
 Database operations are synchronous.

 2025-01-02: To enable SQLite support in node.js, it be started with '--experimental-sqlite'"

INLINE 'import { DatabaseSync } from "node:sqlite";'

CLASSMETHODS

new: path
	^ self fromJs: INLINE 'new DatabaseSync( path.js )'.
!
new: path options: options
	^ self new fromJs: INLINE 'new Database( path.js, options.js )'.
!

METHODS

"Opening & closing"

open
	INLINE 'this.js.open()'.
!
close
	INLINE 'this.js.close()'.
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

