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
	( self checkSqlite: connectionString ) ifTrue: [ ^ self newSqlite: connectionString ].

	self error: 'Cannot match connection string to database type:', connectionString.
!
checkSqlite: connectionString
	^ #( '.db' '.db3' '.sqlite' '.sqlite3' ) some: [ :extension |
		connectionString includes: extension ].
!
newSqlite: connectionString
	"To make SQLite compatible with other databases:
	 First create the database object without opening the database.
	 Then the method 'connect: connectionString' opens the database,
	 without actually using the connection string there."

	| options |
	 options := SqliteDatabaseOptions new open: false.
	^ SqliteDatabase new: connectionString options: options.
!
