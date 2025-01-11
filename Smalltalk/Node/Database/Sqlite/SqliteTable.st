CLASS SqliteTable EXTENDS SqlTable MODULE Database CLASSVARS '' VARS ''

"This class implements an abstract SQL Table.
 Variable rowClass should refer to a subsclass of SqlObject,
 of which instances map to rows in this table,
 using an obigatory autonumber id column."

METHODS

"Quoting and parameters"

quote
	"Return character used for quoting table and column names."
	^ '"'.
!
parameter: index
	"Return a SQL string for the parameter numbered by index."
	^ '?'.
!

"Querying"

queryAll
	| sql statement rows |

	sql := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY "id"'.
	statement := database prepare: sql.
	rows := statement all: #().
	^ rowClass fromRows: rows.
!
queryAllThen: block catch: errorBlock
	"Async compatibility method that is executed sync."
	[ block value: self queryAll ]
		tryCatch: [ :error | errorBlock value: error ].
!
query: condition
	^ self query: condition with: #().
!
query: condition then: block catch: errorBlock
	"Async compatibility method that is executed sync."
	block value: ( self query: condition ).
!
query: condition with: parameters
	| sql statement rows |

	sql := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	statement := database prepare: sql.
	rows := statement all: parameters.
	^ rowClass fromRows: rows.
!
query: condition with: parameters then: block catch: errorBlock
	"Async compatibility method that is executed sync."
	[ block value: ( self query: condition with: parameters ) ]
		tryCatch: [ :error | errorBlock value: error ].
!
queryId: id
	| rows |
	rows := self query: '"id" = ?' with: #( id ).
	^ rows length = 0 ifTrue: [ nil ] ifFalse: [ rows first ].
!
queryId: id then: block catch: errorBlock
	"Async compatibility method that is executed sync."
	[ block value: ( self queryId: id ) ]
		tryCatch: [ :error | errorBlock value: error ].
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
	result := statement run: sqlObject columnValues.

	result changes = 1 ifFalse: [
		self error: 'INSERT did not effect exactly 1 row' ].

	id := result lastInsertRowId.
	id > 0 ifFalse: [
		self error: 'INSERT did not result a valid id: ', result id toString ].

	sqlObject id: id.
!
insert: sqlObject then: block catch: errorBlock
	"Async compatibility method that is executed sync."
	[ self insert: sqlObject. block value: sqlObject ]
		tryCatch: [ :error | errorBlock value: error ].
!

"Updating"

update: sqlObject
	"Update sqlObject in table using id."

	| sql statement result |

	sql := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE "id" = ?'.
	statement := database prepare: sql.
	result := statement run: ( sqlObject columnValues add: sqlObject id ).

	result changes = 1 ifFalse: [
		self error: 'UPDATE by id did not effect exactly 1 row' ].
!
update: sqlObject then: block catch: errorBlock
	"Async compatibility method that is executed sync."
	[ self update: sqlObject. block value: sqlObject ]
		tryCatch: [ :error | errorBlock value: error ].
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
delete: sqlObject then: block catch: errorBlock
	"Async compatibility method that is executed sync."
	[ self delete: sqlObject. block value: sqlObject ]
		tryCatch: [ :error | errorBlock value: error ].
!
