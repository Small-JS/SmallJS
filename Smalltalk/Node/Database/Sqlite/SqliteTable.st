CLASS SqliteTable EXTENDS SqlTable MODULE Database CLASSVARS '' VARS ''

"This class implements an abstract SQL Table.
 Variable rowClass should refer to a subsclass of SqlObject,
 of which instances map to rows in this table,
 using an obigatory autonumber id column."

"Quoting and parameters"

quote
	"Return character used for quoting table and column names."
	^ '"'.
!
parameter: index
	"Return a SQL string for the parameter numbered by index."
	^ '?'.
!

columnValues: sqlObject
	"Return array with values of columns variables, excluding the id column.
	 with conversions needed for SQLite: Date, Boolean."

	^ sqlObject columnValues map: [ :value |
		value class = Date ifTrue: [ value := value toIsoString ].
		value class = Boolean ifTrue: [ value := value ifTrue: [ 1 ] ifFalse: [ 0 ] ].
		value ].
!

"Selecting"

selectAll
	| sql statement rows |

	sql := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY "id"'.
	statement := database prepare: sql.
	rows := statement all: #().
	^ rowClass fromRows: rows.
!
select: condition
	^ self select: condition with: #().
!
select: condition with: parameters
	| sql statement rows |

	sql := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	statement := database prepare: sql.
	rows := statement all: parameters.
	^ rowClass fromRows: rows.
!
selectId: id
	"Return single SqlObject from row with argument id, otherwise nil."
	| sqlObjects |
	sqlObjects := self select: '"id" = ?' with: #( id ).
	^ sqlObjects length = 0 ifTrue: [ nil ] ifFalse: [ sqlObjects first ].
!
run: sql with: parameters
	| statement rows |

	statement := database prepare: sql.
	rows := statement all: parameters.
	^ rowClass fromRows: rows.
!

"Inserting"

insert: sqlObject
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert."
	| sql statement result id |
	sql := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' )'.
	statement := database prepare: sql.
	result := statement run: ( self columnValues: sqlObject ).

	result changes = 1 ifFalse: [
		self error: 'INSERT did not effect exactly 1 row' ].

	id := result lastInsertRowId.
	id > 0 ifFalse: [
		self error: 'INSERT did not result a valid id: ', result id toString ].

	sqlObject id: id.
!

"Updating"

update: sqlObject
	"Update sqlObject in table using id."

	| sql statement result |

	sql := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE "id" = ?'.
	statement := database prepare: sql.
	result := statement run: ( ( self columnValues: sqlObject ) add: sqlObject id ).

	result changes = 1 ifFalse: [
		self error: 'UPDATE by id did not effect exactly 1 row' ].
!

"Deleting"

delete: sqlObject
	"Delete sqlObject in table using id."

	| sql statement result |

	sql := 'DELETE FROM ', self quotedName, ' WHERE "id" = ?'.
	statement := database prepare: sql.
	result := statement run: #( ( sqlObject id ) ).

	result changes = 1 ifFalse: [
		self error: 'DELETE by id did not effect exactly 1 row' ].
!
deleteAll
	database exec: 'DELETE FROM ', self quotedName.
!

