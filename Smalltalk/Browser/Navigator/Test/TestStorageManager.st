CLASS TestStorageManager EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Whether persisting storage is granted depends on the browser and its settings,
 so only the result type is tested."

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
	| persisted persist |
	persisted := await StorageManager default persisted.
	self assert: [ persisted class = Boolean ].
	persist := await StorageManager default persist.
	self assert: [ persist class = Boolean ].
	persisted := await StorageManager default persisted.
	self assert: [ persisted = persist ].
!
