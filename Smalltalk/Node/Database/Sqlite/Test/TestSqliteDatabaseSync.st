CLASS TestSqliteDatabaseSync EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS 'database typeTable type'

disabled
	"Disable these tests if database env var is not set."
	^ ( Process envAt: 'SMALLJS_SQLITE' ) isNil.
!
test
	self open.
	self deleteAll.
	self tableInsert.
	self databaseSelect.
	self tableSelectAll.
	self tableSelect.
	self tableSelectParameters.
	self tableSelectId.
	self tableUpdate.
	self tableDelete.
	self close.
!
open
	| path |
	path := Process envAt: 'SMALLJS_SQLITE'.
	SqliteDatabase checkExists: path.
	database := SqliteDatabase new: path.
	database checkValid.

	typeTable := database connectTable: 'Type' rowClass: MyType.
!
deleteAll
	typeTable deleteAll.
!
tableInsert
	"This test the default type member object for subsequent tests."
	| binary |
	binary := ( Uint8Array new: 8 ) fill: 240 start: 0 end: 8.
	type := MyType new
		string: 'Hello'; integer: 13; float: Float pi;
		date: Date new; binary: binary; boolean: true.

	typeTable insert: type.
	self assert: [ type id > 0 ].
!
databaseSelect
	| statement rows newType |

	statement := database prepare: 'SELECT * FROM "Type" WHERE "string" = ?'.
	rows := statement all: #( ( type string ) ).
	self assert: [ rows length = 1 ].

	newType := MyType fromObject: rows first.
	"Manual type conversions, because the desired types are not known here."
	newType date: ( Date fromString: newType date ).
	newType boolean: ( Boolean fromInteger: newType boolean ).
	self assert: [ newType = type ].
!
tableSelectAll
	| selectedTypes |
	selectedTypes := typeTable selectAll.

	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
tableSelect
	| selectedTypes |
	selectedTypes := typeTable select: '"string" = \'Hello\''.

	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
tableSelectParameters
	| selectedTypes |
	selectedTypes := typeTable select: '"integer" = ?' with: #( 13 ).

	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
tableSelectId
	| selectedType |
	selectedType := typeTable selectId: type id.

	self assert: [ selectedType notNil ].
	self assert: [ selectedType = type ].
!
tableUpdate
	| selectedType |
	type string: 'World'.
	typeTable update: type.
	selectedType := typeTable selectId: type id.

	self assert: [ selectedType notNil ].
	self assert: [ selectedType = type ].
!
tableDelete
	| selectedType |
	typeTable delete: type.
	selectedType := typeTable selectId: type id.

	self assert: [ selectedType isNil ].
!
close
	database close.
!
