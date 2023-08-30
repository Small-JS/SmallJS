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

"Querying"

queryAllThen: block
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' ORDER BY "id"'.
	database query: query
		then: [ :queryResult | block value: ( rowClass fromRows: queryResult rows ) ].
!
query: condition then: block
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query
		then: [ :queryResult | block value: ( rowClass fromRows: queryResult rows ) ].
!
query: condition with: parameters then: block
	| query |

	query := 'SELECT ', self columnListWithId, ' FROM ', self quotedName, ' WHERE ', condition.
	database query: query with: parameters
		then: [ :queryResult | block value: ( rowClass fromRows: queryResult rows ) ].
!
queryId: id then: block
	"Return a new rowClass instance with values from the row with the argument id in the argument SQL table."

	self query: '"id" = $1' with: #( id )
		then: [ :sqlObjects | self onQueryId: id result: sqlObjects then: block ].
!
onQueryId: id result: sqlObjects then: block
	sqlObjects length <= 0 ifTrue: [
		self error: 'Id not found in table: ', name, ', id:', id toString ].
	sqlObjects length > 1 ifTrue: [
		self error: 'Query of id returned more than one row for table: ', name, ', id: ', id toString ].

	^ block value: sqlObjects first.
!

"Modifying"

insert: sqlObject then: block
	"Insert sqlObject as a new row in self.
	 The id variable will be set to a new serial value after the insert."
	| query |

	query := 'INSERT INTO ', self quotedName, ' ( ', self columnList, ' ) VALUES ( ', self insertValuesParameters, ' ) RETURNING id'.
	database query: query with: sqlObject columnValues
		then: [ :queryResult |
			sqlObject id: queryResult toId.
			block value: sqlObject ].
!
update: sqlObject then: block
	"Update sqlObject in table using id."
	| query idParameter |

	idParameter := self parameter: ( rowClass columns length + 1 ).
	query := 'UPDATE ', self quotedName, ' SET ', self updateSetParameters, ' WHERE "id" = ', idParameter, ' RETURNING "id"'.
	database query: query with: ( sqlObject columnValues add: sqlObject id )
		then: [ :queryResult |
			queryResult checkId: sqlObject id.
			block value: sqlObject ].
!
delete: sqlObject then: block
	"Delete sqlObject in table using id."
	| query |

	query := 'DELETE FROM ', self quotedName, ' WHERE "id" = $1 RETURNING id'.
	database query: query with: #( ( sqlObject id ) )
		then: [ :queryResult |
			queryResult checkId: sqlObject id.
			block value: sqlObject ].
!
