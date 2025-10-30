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

async selectAll
	| query rows |
	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY `id`'.
	rows := await database query: query.
	^ rowClass fromRows: rows.
!
async select: condition
	| query rows |
	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	rows := await database query: query.
	^ rowClass fromRows: rows.
!
async select: condition with: parameters
	| query rows |
	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	rows := await database query: query with: parameters.
	^ rowClass fromRows: rows.
!
async selectId: id
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."
	| sqlObjects |
	sqlObjects := await self select: '`id` = ?' with: #( id ).
	sqlObjects length > 1 ifTrue: [
		Error throw: 'Query of id returned more than one row for table: ', name, ', id: ', id toString ].
	^ sqlObjects length = 0 ifTrue: [ nil ] ifFalse: [ sqlObjects first ].
!

"Inserting"

async insert: sqlObject
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert."
	| query result |
	sqlObject id: nil.
	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' )'.
	result := await database query: query with: ( self columnValues: sqlObject ).
	result affectedRows = 1 ifFalse: [
		Error throw: 'INSERT did not effect exactly 1 row for id: ', sqlObject id toString ].
	result insertId > 0 ifFalse: [
		Error throw: 'INSERT did not return a valid id: ', result insertId toString ].
	sqlObject id: result insertId.
!

"Updating"

async update: sqlObject
	"Update sqlObject in table using id."
	| query result |
	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE `id` = ?'.
	result := await database query: query with: ( ( self columnValues: sqlObject ) add: sqlObject id ).
	result affectedRows = 1 ifFalse: [
		Error throw: 'UPDATE by id did not effect exactly 1 row' ].
!

"Deleting"

async deleteAll
	"Delete all rows from table."
	| query |
	query := 'DELETE FROM ', self quotedName.
	await database query: query.
!
async delete: sqlObject
	"Delete sqlObject from table using id."
	| query result |
	query := 'DELETE FROM ', self quotedName, ' WHERE `id` = ?'.
	result := await database query: query with: #( ( sqlObject id ) ).
	result affectedRows = 1 ifFalse: [
		Error throw: 'DELETE by id did not effect exactly 1 row' ].
!
