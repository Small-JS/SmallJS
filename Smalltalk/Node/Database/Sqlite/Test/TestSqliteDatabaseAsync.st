CLASS TestSqliteDatabaseAsync EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS 'database typeTable type'

"Tests SQLite with async interface, that is compatible with that of other supported databases.
 Execution in SQLite is in fact sync, but that should not matter. "

disabled
	"Disable these tests if database env var is not set."
	^ ( Environment at: 'SMALLJS_SQLITE' ) isNil.
!
test
	self connect.
!
connect
	| connectionString |
	connectionString := Environment at: 'SMALLJS_SQLITE'.
	self assert: [ connectionString endsWith: '.db' ].

	database := SqliteDatabase new.
	database connect: connectionString
		then: [ self onConnect ]
		catch: [ :error | error throw ].
!
onConnect
	typeTable := database connectTable: 'Type' rowClass: MyType.

	self tableDeleteAll.
!
tableDeleteAll
	typeTable deleteAllThen: [ self tableInsert ]
		catch: [ :error | error throw ].
!
tableInsert
	| binary |
	binary := ( Uint8Array new: 6 ) fill: 127 start: 0 end: 6.
	type := MyType new
		string: 'Hi'; integer: 7; float: Float pi * 2;
		date: Date new; binary: binary; boolean: true.

	typeTable insert: type
		then: [ self onTableInsert ]
		catch: [ :error | error throw ].
!
onTableInsert
	self assert: [ type id > 0 ].

	self databaseSelect.
!
databaseSelect
	| statement |
	statement := database prepare: 'SELECT * FROM "Type" WHERE "string" = ?'.
	statement all: #( ( type string ) )
		then: [ :rows | self onDatabaseSelect: rows ]
		catch: [ :error | error throw ].
!
onDatabaseSelect: rows
	| newType |
	self assert: [ rows length = 1 ].

	newType := MyType fromObject: rows first.
	"Manual type conversions, because the desired types are not known here."
	newType date: ( Date fromString: newType date ).
	newType boolean: ( Boolean fromInteger: newType boolean ).
	self assert: [ newType = type ].

	self tableSelectAll.
!
tableSelectAll
	typeTable selectAllThen: [ :types | self onTableSelectAll: types ]
		catch: [ :error | error throw ].
!
onTableSelectAll: selectedTypes
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].

	self tableSelect.
!
tableSelect
	typeTable select:  '"string" = \'Hi\''
		then: [ :types | self onTableSelect: types ]
		catch: [ :error | error throw ].
!
onTableSelect: selectedTypes
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].

	self tableSelectParameters.
!
tableSelectParameters
	typeTable select: '"integer" = ?' with: #( 7 )
		then: [ :types | self onTableSelectParameters: types ]
		catch: [ :error | error throw ].
!
onTableSelectParameters: selectedTypes
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].

	self tableSelectId.
!
tableSelectId
	typeTable selectId: type id
		then: [ :type | self onTableSelectId: type ]
		catch: [ :error | error throw ].
!
onTableSelectId: selectedType
	self assert: [ selectedType notNil ].
	self assert: [ selectedType = type ].

	self tableUpdate.
!
tableUpdate
	type string: 'There'.
	typeTable update: type
		then: [ self tableUpdateCheck ]
		catch: [ :error | error throw ].
!
tableUpdateCheck
	typeTable selectId: type id
		then: [ :type | self onTableUpdateCheck: type ]
		catch: [ :error | error throw ].
!
onTableUpdateCheck: selectedType
	self assert: [ selectedType notNil ].
	self assert: [ selectedType = type ].

	self tableDelete.
!
tableDelete
	typeTable delete: type
		then: [ self tableDeleteCheck ]
		catch: [ :error | error throw ].
!
tableDeleteCheck
	typeTable selectId: type id
		then: [ :type | self onTableDeleteCheck: type ]
		catch: [ :error | error throw ].
!
onTableDeleteCheck: selectedType
	self assert: [ selectedType isNil ].

	self end.
!
end
	database end.
!
