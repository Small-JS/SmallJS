CLASS TestMariadbDatabase EXTENDS Test MODULE TestDatabase CLASSVARS ''
	VARS 'database typeTable type'

"Also tests class MariadbTable"

disabled
	"Temporaryly disable this module when there are connection timeouts
	 due to breakpoints in unrelated async functions."
	"^ true."

	"Disable these tests if database env var is not set."
	^ ( Environment at: 'SMALLJS_MARIADB' ) isNil.
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
	connectionString := Environment at: 'SMALLJS_MARIADB'.
	self assert: [ connectionString startsWith: 'mariadb:' ].

	database := MariadbDatabase new.
	await database connect: connectionString.

	typeTable := database connectTable: 'Type' rowClass: MyType.
!
async tableDeleteAll
	await typeTable deleteAll.
!
async tableInsert
	| binary |
	"The mariadb npm package supports Node.js class Buffer and not the common class UInt8Array."
	binary := ( Buffer new: 6 ) fill: 127 start: 0 end: 6.
	type := MyType new
		string: 'Hi'; integer: 7; float: Float pi * 2;
		date: Date new; binary: binary; boolean: true.
	await typeTable insert: type.
	self assert: [ type id > 0 ].
!
async databaseSelect
	| result newType |
	result := await database query: 'SELECT * FROM `Type` WHERE `string` = ?' with: #( ( type string ) ).
	self assert: [ result length = 1 ].

	newType := MyType fromObject: result first.
	"Manual type conversion, because the desired type is not known here."
	newType date: ( Date fromString: newType date ).
	newType boolean: ( Boolean fromInteger: newType boolean ).
	self assert: [ newType = type ].
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
	| updatedType |
	type string: 'There'.
	await typeTable update: type.

	updatedType := await typeTable selectId: type id.
	self assert: [ updatedType notNil ].
	self assert: [ updatedType = type ].
!
async tableDelete
	| deletedType |
	await typeTable delete: type.

	deletedType := await typeTable selectId: type id.
	self assert: [ deletedType isNil ].
!
async end
	await database end.
!
