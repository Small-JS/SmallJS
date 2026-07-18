CLASS PostgresTable EXTENDS SqlTable MODULE DatabasePostgres CLASSVARS '' VARS ''
	"This class implements an abstract SQL Table.
	 Variable rowClass should refer to a subsclass of SqlObject, of which instances map to rows in this table."

METHODS

"Selecting"

async selectAll
	| query queryResult |
	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY `id`'.
	queryResult := await self query: query.
	^ rowClass fromRows: queryResult rows.
!
async select: condition
	| query queryResult |
	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	queryResult := await self query: query.
	^ rowClass fromRows: queryResult rows.
!
async select: condition with: parameters
	| query queryResult |
	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	queryResult := await self query: query with: parameters.
	^ rowClass fromRows: queryResult rows.
!
async selectId: id
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."
	| sqlObjects |
	sqlObjects := await self select: '`id` = ?' with: #( id ).
	sqlObjects length > 1 ifTrue: [
		Error throw: 'Query of id returned more than one row for table: ', name, ', id: ', id toString ].
	^ sqlObjects length = 1 ifTrue: [ sqlObjects first ] ifFalse: [ nil ].
!

"Inserting"

async insert: sqlObject
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert.
	 If the insert fails, the id will be (re)set to nil."
	| query queryResult id |
	sqlObject id: nil.
	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList,
		' ) VALUES ( ', self insertValuesParameters, ' ) RETURNING id'.
	queryResult := await self query: query with: ( self columnValues: sqlObject ).

	id := queryResult toId.
	id ifNil: [
		Error throw: 'Insert did not return a valid id' ].
	sqlObject id: id.
!

"Updating"

async update: sqlObject
	"Update sqlObject in table using id."
	| query queryResult id |

	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters,
		' WHERE `id` = ? RETURNING `id`'.
	queryResult := await self query: query with: ( sqlObject columnValues add: sqlObject id ).

	id := queryResult toId.
	id = sqlObject id ifFalse: [
		Error throw: 'Update did not return a expected id: ', id ].
!

"Deleting"

async deleteAll
	"Delete all rows from table."
	| query |
	query := 'DELETE FROM ', self quotedName.
	await self query: query.
!
async delete: sqlObject
	"Delete sqlObject row from table using id."
	| query queryResult id |
	query := 'DELETE FROM ', self quotedName, ' WHERE `id` = ? RETURNING id'.
	queryResult := await self query: query with: #( ( sqlObject id ) ).

	id := queryResult toId.
	id = sqlObject id ifFalse: [
		Error throw: 'Delete did not return a expected id: ', id ].
!
async query: query
	^ await database query: ( self translateQuery: query ).
!
async query: query with: parameters
	^ await database query: ( self translateQuery: query ) with: parameters.
!
translateQuery: query
	"Translate query to Postgres conventions with:
		- double quoted table and column names
		- single quoted strings
		- numbered parameters like $1."
	| resultQuery parameterIndex string |

	query := ( query replaceAll: '"' with: '\'' )
			replaceAll: '`' with: '"'.

	resultQuery := ''.
	parameterIndex := 0.
	query do: [ :char |
		string := char = $?
			ifTrue: [ parameterIndex increment. '$', parameterIndex ]
			ifFalse: [ char toString ].
		resultQuery := resultQuery, string ].

	^ resultQuery.
!
