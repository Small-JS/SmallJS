CLASS PostgresTable EXTENDS SqlTable MODULE Database CLASSVARS '' VARS ''
	"This class implements an abstract SQL Table.
	 Variable rowClass should refer to a subsclass of SqlObject, of which instances map to rows in this table."

METHODS

"Quoting and parameters"

quote
	"Return character used for quoting table and column names as a strings."
	^ '"'.
!
parameter: index
	"Return a SQL srign for the paramater numbered by index"
	^ '$', index toString.
!

"Selecting"

selectAllThen: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY "id"'.
	database query: query
		then: [ :queryResult | block value: ( rowClass fromRows: queryResult rows ) ]
		catch: errorBlock.
!
select: condition then: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query
		then: [ :queryResult | block value: ( rowClass fromRows: queryResult rows ) ]
		catch: errorBlock.
!
select: condition with: parameters then: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query with: parameters
		then: [ :queryResult | block value: ( rowClass fromRows: queryResult rows ) ]
		catch: errorBlock.
!
selectId: id then: block catch: errorBlock
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."

	self select: '"id" = $1'
		with: #( id )
		then: [ :sqlObjects | self onSelectId: id result: sqlObjects then: block catch: errorBlock ]
		catch: errorBlock.
!
onSelectId: id result: sqlObjects then: block catch: errorBlock
	| sqlObject |
	sqlObjects length > 1 ifTrue: [
		^ errorBlock value: ( Error new: 'Query of id returned more than one row for table: ', name, ', id: ', id toString ) ].

	sqlObject := sqlObjects length = 1 ifTrue: [ sqlObjects first ] ifFalse: [ nil ].
	^ block value: sqlObject.
!

"Inserting"

insert: sqlObject then: block catch: errorBlock
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert.
	 If the insert fails, the id will be (re)set to nil."
	| query |

	sqlObject id: nil.
	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' ) RETURNING id'.
	database query: query
		with: ( self columnValues: sqlObject )
		then: [ :queryResult | self onInsert: queryResult sqlObject: sqlObject then: block catch: errorBlock ]
		catch: errorBlock.
!
onInsert: queryResult sqlObject: sqlObject then: block catch: errorBlock
	| id |
	id := queryResult toId.
	id ifNil: [
		^ errorBlock value: ( Error new: 'Insert did not return a valid id' ) ].

	sqlObject id: id.
	block value.
!

"Updating"

update: sqlObject then: block catch: errorBlock
	"Update sqlObject in table using id."
	| query idParameter |

	idParameter := self parameter: ( rowClass columns length + 1 ).
	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE "id" = ', idParameter, ' RETURNING "id"'.
	database query: query
		with: ( sqlObject columnValues add: sqlObject id )
		then: [ :queryResult | self onUpdate: queryResult sqlObject: sqlObject then: block catch: errorBlock ]
		catch: errorBlock.
!
onUpdate: queryResult sqlObject: sqlObject then: block catch: errorBlock
	| id |
	id := queryResult toId.
	id = sqlObject id ifFalse: [
		^ errorBlock value: ( Error new: 'Update did not return a expected id: ', id ) ].

	block value.
!

"Deleting"

deleteAllThen: block catch: errorBlock
	"Delete all rows from table."
	| query |

	query := 'DELETE FROM ', self quotedName.
	database query: query
		then: [ block value ]
		catch: errorBlock.
!
delete: sqlObject then: block catch: errorBlock
	"Delete sqlObject in table using id."
	| query |

	query := 'DELETE FROM ', self quotedName, ' WHERE "id" = $1 RETURNING id'.
	database query: query
		with: #( ( sqlObject id ) )
		then: [ :queryResult | self onDelete: queryResult sqlObject: sqlObject then: block catch: errorBlock ]
		catch: errorBlock.
!
onDelete: queryResult sqlObject: sqlObject then: block catch: errorBlock
	| id |
	id := queryResult toId.
	id = sqlObject id ifFalse: [
		^ errorBlock value: ( Error new: 'Delete did not return a expected id: ', id ) ].

	block value.
!

