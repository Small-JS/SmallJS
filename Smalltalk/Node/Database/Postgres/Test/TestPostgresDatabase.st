CLASS TestPostgresDatabase EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS 'database typeTable type'

disabled
	"Disable these tests if database env var is not set."
	^ ( Process envAt: 'SMALLJS_POSTGRES' ) isNil.
!
test
	self connect.
!
connect
	| connectionString |
	connectionString := Process envAt: 'SMALLJS_POSTGRES'.
	self assert: [ connectionString startsWith: 'postgres:' ].

	database := PostgresDatabase new.
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
	database query: 'SELECT * FROM "Type" WHERE "string" = $1'
		with: #( ( type string ) )
		then: [ :result | self onDatabaseSelect: result ]
		catch: [ :error | error throw ].
!
onDatabaseSelect: result
	| newType |
	self assert: [ result rows length = 1 ].

	newType := MyType fromObject: result rows first.
	"Manual type conversion, because the desired type is not known here."
	newType date: ( Date fromString: newType date ).

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
	typeTable select: '"integer" = $1'
		with: #( 7 )
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
