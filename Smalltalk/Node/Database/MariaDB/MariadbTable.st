CLASS MariadbTable EXTENDS SqlTable MODULE Database CLASSVARS '' VARS ''

"Quoting and parameters"

quote
	"Return character used for quoting table and column names as a strings."
	^ '`'.
!
parameter: index
	"Return a SQL string for the parameter numbered by index"
	^ '?'.
!

"Querying"

queryAllThen: block
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY `id`'.
	database query: query
		then: [ :rows | block value: ( rowClass fromRows: rows ) ].
!
query: condition then: block
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query
		then: [ :rows | block value: ( rowClass fromRows: rows ) ].
!
query: condition with: parameters then: block
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query with: parameters
		then: [ :rows | block value: ( rowClass fromRows: rows ) ].
!
queryId: id then: block
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."

	self query: '`id` = ?' with: #( id )
		then: [ :sqlObjects | self onQueryId: id sqlObjects: sqlObjects then: block ].
!
onQueryId: id sqlObjects: sqlObjects then: block
	sqlObjects length = 1 ifFalse: [
		self error: 'Query by id did not return exactly 1 row. Id: ', id toString ].

	^ block value: sqlObjects first.
!

"Inserting"

insert: sqlObject then: block
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert."

	| query |

	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' )'.

	database query: query with: sqlObject columnValues
		then: [ :result | self onInsert: sqlObject result: result then: block ].
!
onInsert: sqlObject result: result then: block
	result affectedRows = 1 ifFalse: [
		self error: 'INSERT did not effect exactly 1 row' ].

	result insertId > 0 ifFalse: [
		self error: 'INSERT did not result a valid id: ', result insertId toString ].

	sqlObject id: result insertId.
	block value: sqlObject.
!

"Updating"

update: sqlObject then: block
	"Update sqlObject in table using id."

	| query |

	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE `id` = ?'.
	database query: query with: ( sqlObject columnValues add: sqlObject id )
		then: [ :result | self onUpdate: sqlObject result: result then: block ].
!
onUpdate: sqlObject result: result then: block
	result affectedRows = 1 ifFalse: [
		self error: 'UPDATE by id did not effect exactly 1 row' ].

	block value: sqlObject.
!

"Deleting"

delete: sqlObject then: block
	"Delete sqlObject in table using id."

	| query |

	query := 'DELETE FROM ', self quotedName, ' WHERE `id` = ?'.
	database query: query with: #( ( sqlObject id ) )
		then: [ :result | self onDelete: sqlObject result: result then: block ].
!
onDelete: sqlObject result: result then: block
	result affectedRows = 1 ifFalse: [
		self error: 'Delete by id did not effect exactly 1 row' ].

	block value: sqlObject.
!
