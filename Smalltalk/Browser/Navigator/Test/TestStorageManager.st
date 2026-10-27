CLASS TestStorageManager EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Whether persisting storage is granted depends on the browser and its settings,
 so only the result type of persisted is tested.
 Method persist can show a permission prompt (e.g. in Firefox), so it is tested with a mock JS object."

METHODS

test
	| storageManager |
	storageManager := Window default navigator storage.
	self assert: [ storageManager class = StorageManager ].
	self assert: [ StorageManager default = storageManager ].
!
async testEstimate
	| estimate |
	estimate := await StorageManager default estimate.
	self assert: [ estimate class = StorageEstimate ].
	self assert: [ estimate quota > 0 ].
	self assert: [ estimate usage >= 0 ].
	self assert: [ estimate usage <= estimate quota ].
!
async testPersist
	| storageManager persisted persist |
	persisted := await StorageManager default persisted.
	self assert: [ persisted class = Boolean ].

	storageManager := self mockStorageManager.
	persisted := await storageManager persisted.
	self assert: [ persisted not ].
	persist := await storageManager persist.
	self assert: [ persist ].
	persisted := await storageManager persisted.
	self assert: [ persisted ].
!
mockStorageManager
	^ StorageManager fromJs: INLINE '{
		isPersisted: false,
		async persist() { this.isPersisted = true; return true; },
		async persisted() { return this.isPersisted; } }'.
!
