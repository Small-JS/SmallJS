CLASS SqlTable EXTENDS Object MODULE Database CLASSVARS '' VARS 'name database rowClass'

"This class implements an abstract SQL Table.
The table in the database should have an column named 'id' of type autonumber to manage peristance.
Variable rowClass should refer to a subsclass of SqlObject, of which instances map to rows in this table."

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

quote
	"Return character used for quoting table and column names as a strings."
	self error: 'Subclass responsibility'.
!
quoted: aName
	"Return argument name quoted using database quoting convention."
	^ self quote, aName, self quote.
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

"Parameters"

parameter: index
	"Return a SQL string for the parameter numbered by index"
	self error: 'Subclass responsibility'.
!
insertValuesParameters
	"Return a string suitable for e.g. the VALUES clause of an INSERT statement when using parameters, excluding the id column.
	 E.g.: '$1, $2, $3' for a three column table, excluding the id column."

	| result |
	result := ''.

	1 to: rowClass columns length do: [ :index |
		result = '' ifFalse: [ result := result, ', ' ].
		result := result, ( self parameter: index ) ].

	^ result.
!
updateSetParameters
	"Return a string suitable for e.g. the SET clause of an UPDATE argument when using parameters, excluding the id column.
	 E.g.: ' col1 = $1, col2 = $2, col3 = $3' for a three column table, excluding the id column, but using quoted column names."

	| result |

	result := ''.
	1 to: rowClass columns length do: [ :index |
		result = '' ifFalse: [ result := result, ', ' ].
		result := result, ( self quoted: ( rowClass columns at: index - 1 ) first ), ' = ', ( self parameter: index ) ].

	^ result.
!
columnValues: sqlObject
	"Return array with values of columns variables, excluding the id column.
	 This method may be overloaded with database specific value converions needed,
	 depending on the type support of that database."

	"The default is no conversions."
	^ sqlObject columnValues.
!
