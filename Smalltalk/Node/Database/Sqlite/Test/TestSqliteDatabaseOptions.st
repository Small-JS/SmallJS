CLASS TestSqliteDatabaseOptions EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS ''

test
	| options |

	options := SqliteDatabaseOptions new.

	options open: true.
	self assert: [ options open ].

	options readOnly: true.
	self assert: [ options readOnly ].

	options enableForeignKeyConstraints: true.
	self assert: [ options enableForeignKeyConstraints ].

	options enableDoubleQuotedStringLiterals: true.
	self assert: [ options enableDoubleQuotedStringLiterals ].

	options allowExtension: true.
	self assert: [ options allowExtension ].
!
