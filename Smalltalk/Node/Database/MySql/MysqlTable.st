CLASS MysqlTable EXTENDS SqlTable MODULE Database CLASSVARS '' VARS ''
	"This class implements an abstract SQL Table.
	 Variable rowClass should refer to a subsclass of SqlObject, of which instances map to rows in this table."

METHODS

"Quoting and parameters"

quote
	"Return character used for quoting table and column names."
	^ '`'.
!
parameter: index
	"Return a SQL string for the parameter numbered by index"
	^ '?'.
!

"Querying"

queryAllThen: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY `id`'.
	database query: query
		then: [ :rows | block value: ( rowClass fromRows: rows ) ]
		catch: errorBlock.
!
query: condition then: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query
		then: [ :rows | block value: ( rowClass fromRows: rows ) ]
		catch: errorBlock.
!
query: condition with: parameters then: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query
		with: parameters
		then: [ :rows | block value: ( rowClass fromRows: rows ) ]
		catch: errorBlock.
!
queryId: id then: block catch: errorBlock
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."

	self query: '`id` = ?'
		with: #( id )
		then: [ :sqlObjects | self onQueryId: id sqlObjects: sqlObjects then: block catch: errorBlock ]
		catch: errorBlock.
!
onQueryId: id sqlObjects: sqlObjects then: block catch: errorBlock
	sqlObjects length = 1 ifFalse: [
		^ errorBlock value: ( Error message: 'Query by id did not return exactly 1 row. Id: ', id toString ) ].

	^ block value: sqlObjects first.
!

"Inserting"

insert: sqlObject then: block catch: errorBlock
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert."

	| query |

	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' )'.

	database query: query
		with: sqlObject columnValues
		then: [ :result | self onInsert: sqlObject result: result then: block catch: errorBlock ]
		catch: errorBlock.
!
onInsert: sqlObject result: result then: block catch: errorBlock
	result affectedRows = 1 ifFalse: [
		^ errorBlock value: ( Error message: 'INSERT did not effect exactly 1 row' ) ].

	result insertId > 0 ifFalse: [
		^ errorBlock value: ( Error message: 'INSERT did not result a valid id: ', result insertId toString ) ].

	sqlObject id: result insertId.
	block value: sqlObject.
!

"Updating"

update: sqlObject then: block catch: errorBlock
	"Update sqlObject in table using id."

	| query |

	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE `id` = ?'.
	database query: query
		with: ( sqlObject columnValues add: sqlObject id )
		then: [ :result | self onUpdate: sqlObject result: result then: block catch: errorBlock ]
		catch: errorBlock.
!
onUpdate: sqlObject result: result then: block catch: errorBlock
	result affectedRows = 1 ifFalse: [
		^ errorBlock value: ( Error message: 'UPDATE by id did not effect exactly 1 row' ) ].

	block value: sqlObject.
!

"Deleting"

delete: sqlObject then: block catch: errorBlock
	"Delete sqlObject in table using id."

	| query |

	query := 'DELETE FROM ', self quotedName, ' WHERE `id` = ?'.
	database query: query
		with: #( ( sqlObject id ) )
		then: [ :result | self onDelete: sqlObject result: result then: block catch: errorBlock ]
		catch: errorBlock.
!
onDelete: sqlObject result: result then: block catch: errorBlock
	result affectedRows = 1 ifFalse: [
		^ errorBlock value: ( Error message: 'Delete by id did not effect exactly 1 row' ) ].

	block value: sqlObject.
!
