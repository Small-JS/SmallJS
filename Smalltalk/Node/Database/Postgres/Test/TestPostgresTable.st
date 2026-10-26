CLASS TestPostgresTable EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS ''

"Tests PostgresTable functions that do not need a database connection."

testTranslateQuery
	| table |
	table := PostgresTable database: nil name: 'Type' rowClass: MyType.

	self assert: [ ( table translateQuery: 'SELECT * FROM `Type`' ) = 'SELECT * FROM "Type"' ].
	self assert: [ ( table translateQuery: '`a` = ? AND `b` = ?' ) = '"a" = $1 AND "b" = $2' ].
	self assert: [ ( table translateQuery: '`a` = "Hi"' ) = '"a" = \'Hi\'' ].
	self assert: [ ( table translateQuery: '`a` = "Why?" AND `b` = ?' ) = '"a" = \'Why?\' AND "b" = $1' ].
!
