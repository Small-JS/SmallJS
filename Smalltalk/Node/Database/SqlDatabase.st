CLASS SqlDatabase EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''
	"This class implements common database functionality.
	 Note: The method 'end' should be called when you are done with the database connection
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
