CLASS TestMysqlDatabase EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS 'database typeTable type'

disabled
	"Temporaryly disable this module when there are connection timeouts
	 due to breakpoints in unrelated async functions."
	"^ true."

	"Disable these tests if database env var is not set."
	^ ( Environment at: 'SMALLJS_MYSQL' ) isNil.
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
	connectionString := Environment at: 'SMALLJS_MYSQL'.
	self assert: [ connectionString startsWith: 'mysql:' ].

	database := MysqlDatabase new.
	await database connect: connectionString.

	typeTable := database connectTable: 'type' rowClass: MyType.
!
async tableDeleteAll
	typeTable deleteAllThen: [ self tableInsert ]
		catch: [ :error | error throw ].
!
async tableInsert
	| binary |
	"The mysql2 package supports Node.js class Buffer and not the common class UInt8Array."
	binary := ( Buffer new: 6 ) fill: 127 start: 0 end: 6.
	type := MyType new
		string: 'Hi'; integer: 7; float: Float pi * 2;
		date: Date new; binary: binary; boolean: true.
	await typeTable insert: type.
	self assert: [ type id > 0 ].
!
async databaseSelect
	| query result selectedType |
	query := 'SELECT * FROM `Type` WHERE `string` = ?'.
	result := await database query: query with: #( ( type string ) ).
	self assert: [ result length = 1 ].

	selectedType := MyType fromObject: result first.
	"Manual date and boolean type conversion."
	selectedType date: ( Date fromString: selectedType date ).
	selectedType boolean: ( Boolean fromInteger: selectedType boolean ).
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
	selectedTypes := await typeTable select: '`string` = "Hi"'.
	self assert: [ selectedTypes length = 1 ].
	self assert: [ selectedTypes first = type ].
!
async tableSelectWith
	| selectedTypes |
	selectedTypes := await typeTable select: '`integer` = ?' with: #( 7 ).
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
	| selectedType |
	type string: 'There'.
	await typeTable update: type.

	selectedType := await typeTable selectId: type id.
	self assert: [ selectedType notNil ].
	self assert: [ selectedType = type ].
!
async tableDelete
	| selectedType |
	await typeTable delete: type.

	selectedType := await typeTable selectId: type id.
	self assert: [ selectedType isNil ].
!
async end
	await database end.
!
