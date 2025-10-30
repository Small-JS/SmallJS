CLASS TestPostgresDatabase EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS 'database typeTable type'

disabled
	"Temporaryly disable this module when there are connection timeouts
	 due to breakpoints in unrelated async functions."
	"^ true."

	"Disable these tests if database env var is not set."
	^ ( Environment at: 'SMALLJS_POSTGRES' ) isNil.
!
async test
	await self connect.
	await self tableDeleteAll.
	await self tableInsert.
	await self databaseSelect.
	await self tableSelectAll.
	await self tableSelect.
	await self tableSelectWith.
	await self tableSelectId.
	await self tableUpdate.
	await self tableDelete.
	await self end.
!
async connect
	| connectionString |
	connectionString := Environment at: 'SMALLJS_POSTGRES'.
	self assert: [ connectionString startsWith: 'postgres:' ].

	database := PostgresDatabase new.
	await database connect: connectionString.

	typeTable := database connectTable: 'Type' rowClass: MyType.
!
async tableDeleteAll
	await typeTable deleteAll.
!
async tableInsert
	| binary |
	binary := ( Uint8Array new: 6 ) fill: 127 start: 0 end: 6.
	type := MyType new
		string: 'Hi'; integer: 7; float: Float pi * 2;
		date: Date new; binary: binary; boolean: true.

	await typeTable insert: type.
	self assert: [ type id > 0 ].
!
async databaseSelect
	| query result selectedType |
	query := 'SELECT * FROM "Type" WHERE "string" = $1'.
	result := await database query: query with: #( ( type string ) ).
	self assert: [ result rows length = 1 ].

	selectedType := MyType fromObject: result rows first.
	"Manual date type conversion, because the desired type is not known here."
	selectedType date: ( Date fromString: selectedType date ).
	self assert: [ selectedType = type ].
!
async tableSelectAll
	| selectedTypes |
	selectedTypes := await typeTable selectAll.
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
async tableSelect
	| selectedTypes |
	selectedTypes := await typeTable select:  '"string" = \'Hi\''.
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
async tableSelectWith
	| selectedTypes |
	selectedTypes := await typeTable select: '"integer" = $1' with: #( 7 ).
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
async tableSelectId
	| selectedType |
	selectedType := await typeTable selectId: type id.
	self assert: [ selectedType notNil ].
	self assert: [ selectedType = type ].
!
async tableUpdate
	| updatedType |
	type string: 'There'.
	await typeTable update: type.

	updatedType := await typeTable selectId: type id.
	self assert: [ updatedType notNil ].
	self assert: [ updatedType = type ].
!
async tableDelete
	| detetedType |
	await typeTable delete: type.

	detetedType := await typeTable selectId: type id.
	self assert: [ detetedType isNil ].
!
async end
	await database end.
!
