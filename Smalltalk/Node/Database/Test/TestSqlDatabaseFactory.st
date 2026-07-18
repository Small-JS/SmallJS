CLASS TestSqlDatabaseFactory EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS ''

test
	self assert: [ ( SqlDatabaseFactory newFor: '../Database/SQLite/smalljs.db' ) class = SqliteDatabase ].
	self assert: [ ( SqlDatabaseFactory newFor:  'postgres://postgres:postgres@localhost:5432/smalljs' ) class = PostgresDatabase ].
	self assert: [ ( SqlDatabaseFactory newFor:  'mariadb://root:MariaDB@localhost:3307/smalljs?connectTimeout=0' ) class = MariadbDatabase ].
	self assert: [ ( SqlDatabaseFactory newFor:  'mysql://root:MySQL@localhost:3306/smalljs?connectTimeout=0' ) class = MysqlDatabase ].
!
