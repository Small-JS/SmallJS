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

"Selecting"

selectAllThen: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY `id`'.
	database query: query
		then: [ :rows | block value: ( rowClass fromRows: rows ) ]
		catch: errorBlock.
!
select: condition then: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query
		then: [ :rows | block value: ( rowClass fromRows: rows ) ]
		catch: errorBlock.
!
select: condition with: parameters then: block catch: errorBlock
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query with: parameters
		then: [ :rows | block value: ( rowClass fromRows: rows ) ]
		catch: errorBlock.
!
selectId: id then: block catch: errorBlock
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."

	self select: '`id` = ?'
		with: #( id )
		then: [ :sqlObjects | self onSelectId: id sqlObjects: sqlObjects then: block catch: errorBlock ]
		catch: errorBlock.
!
onSelectId: id sqlObjects: sqlObjects then: block catch: errorBlock
	| sqlObject |

	sqlObjects length > 1 ifTrue: [
		^ errorBlock value: ( Error new: 'Query of id returned more than one row for table: ', name, ', id: ', id toString ) ].

	sqlObject := sqlObjects length = 1 ifTrue: [ sqlObjects first ] ifFalse: [ nil ].
	^ block value: sqlObject.
!

"Inserting"

insert: sqlObject then: block catch: errorBlock
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert."

	| query |

	sqlObject id: nil.
	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' )'.
	database query: query
		with: ( self columnValues: sqlObject )
		then: [ :result | self onInsert: sqlObject result: result then: block catch: errorBlock ]
		catch: errorBlock.
!
onInsert: sqlObject result: result then: block catch: errorBlock
	result affectedRows = 1 ifFalse: [
		^ errorBlock value: ( Error message: 'INSERT did not effect exactly 1 row for id: ', sqlObject id toString ) ].

	result insertId > 0 ifFalse: [
		^ errorBlock value: ( Error new: 'INSERT did not return a valid id: ', result insertId toString ) ].

	sqlObject id: result insertId.
	block value: sqlObject.
!

"Updating"

update: sqlObject then: block catch: errorBlock
	"Update sqlObject in table using id."

	| query |

	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE `id` = ?'.
	database query: query
		with: ( ( self columnValues: sqlObject ) add: sqlObject id )
		then: [ :result | self onUpdate: sqlObject result: result then: block catch: errorBlock ]
		catch: errorBlock.
!
onUpdate: sqlObject result: result then: block catch: errorBlock
	result affectedRows = 1 ifFalse: [
		^ errorBlock value: ( Error new: 'UPDATE by id did not effect exactly 1 row' ) ].

	block value: sqlObject.
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

	query := 'DELETE FROM ', self quotedName, ' WHERE `id` = ?'.
	database query: query
		with: #( ( sqlObject id ) )
		then: [ :result | self onDelete: sqlObject result: result then: block catch: errorBlock ]
		catch: errorBlock.
!
onDelete: sqlObject result: result then: block catch: errorBlock
	result affectedRows = 1 ifFalse: [
		^ errorBlock value: ( Error new: 'DELETE by id did not effect exactly 1 row' ) ].

	block value: sqlObject.
!
