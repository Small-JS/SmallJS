CLASS SqlTable EXTENDS Object MODULE Database CLASSVARS '' VARS 'name database rowClass'

"This class implements an abstract SQL Table.
The table in the database should have an column named 'id' of type autonumber to manage peristance.
Variable rowClass should refer to a subsclass of SqlObject, of which instances map to rows in this table.

SmallJS has common standard for specifying table namescolumn names and string in table queries:
- Table and columns names are enclodes in back quotes.
- Query parameters are always indicated with a question mark and are not numbered.
	So the parameters must be supplied in the same order as they appear in the query.
E.g.: SELECT * FROM `Person` WHERE `name` = ?
For databases with different conventions, queries are modified before execution."

CLASSMETHODS

database: database name: name rowClass: rowClass
	^ self new
		database: database; name: name; rowClass: rowClass.
!

METHODS

"Accessing"

name
	^ name.
!
name: aName
	name := aName.
!
database
	^ database.
!
database: aDatabase
	database := aDatabase.
!
rowClass
	^ rowClass.
!
rowClass: aRowClass
	rowClass := aRowClass.
!

"Quoting"

quoted: aName
	"Return argument name quoted using default quoting convention
	 for table and column names."
	^ '`', aName, '`'.
!
quotedName
	"Return table name quoted."
	^ self quoted: name.
!

"Columns"

columnList
	"Return my columns as comma separated list excluding the id column."
	| result |
	result := ''.
	self rowClass columns do: [ :column |
		result = '' ifFalse: [ result := result + ', ' ].
		result := result + ( self quoted: column first ) ].
	^ result.
!
columnListWithId
	"Return my columns as comma separated list"
	^ ( self quoted: 'id' ) + ', ' + self columnList.
!
columnValues: sqlObject
	"Return array with values of columns variables, excluding the id column.
	 This method may be overloaded with database specific value converions needed,
	 depending on the type support of that database."

	"The default is no conversions."
	^ sqlObject columnValues.
!

"Parameters"

insertValuesParameters
	"Return a string suitable for the VALUES clause of an INSERT statement
	using parameters, excluding the id column.
	E.g. for a three column table: ?, ?, ? "

	| result |
	result := ''.

	rowClass columns length timesRepeat: [
		result = '' ifFalse: [ result := result, ', ' ].
		result := result, '?' ].

	^ result.
!
updateSetParameters
	"Return a string suitable for e.g. the SET clause of an UPDATE argument
	when using quoted column names, parameters, excluding the id column.
	E.g. for a three column table: `col1` = ?, `col2` = ?, `col3` = ?' "

	| result |

	result := ''.
	1 to: rowClass columns length do: [ :index |
		result = '' ifFalse: [ result := result, ', ' ].
		result := result, ( self quoted: ( rowClass columns at: index - 1 ) first ), ' = ?' ].

	^ result.
!
