CLASS SqlDatabaseFactory EXTENDS JsObject MODULE DatabaseFactory CLASSVARS '' VARS ''

"This class implements functionality to create supported database instances.
Projects referencing this class must also import all npm packages of all supported databases.

Note 1:
The method 'end' should be called when you are done with the database connection
to free up resources and be able to terminate your app."

CLASSMETHODS

newFor: connectionString
	"Create database instance indicated by the connection string"

	( connectionString startsWith: 'postgres://' ) ifTrue: [ ^ PostgresDatabase new ].
	( connectionString startsWith: 'mariadb://' ) ifTrue: [ ^ MariadbDatabase new ].
	( connectionString startsWith: 'mysql://' ) ifTrue: [ ^ MysqlDatabase new ].
	( self checkSqlite: connectionString ) ifTrue: [ ^ SqliteDatabase new ].

	self error: 'Cannot match connection string to database type:', connectionString.
!
checkSqlite: connectionString
	connectionString := connectionString toLowerCase.
	^ #( '.db' '.db3' '.sqlite' '.sqlite3' ) some: [ :extension |
		connectionString endsWith: extension ].
!
