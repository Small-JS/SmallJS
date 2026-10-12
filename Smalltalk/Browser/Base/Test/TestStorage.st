CLASS TestStorage EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

testLocalStorage
	"Only use test keys, don't clear localStorage because it persists for the whole site."
	| storage length |
	storage := Window default localStorage.
	storage removeItem: 'testLocalKey'.
	length := storage length.
	self assert: [ ( storage item: 'testLocalKey' ) isNil ].

	storage item: 'testLocalKey' value: 'testLocalValue'.
	self assert: [ storage length = ( length + 1 ) ].
	self assert: [ ( storage item: 'testLocalKey' ) = 'testLocalValue' ].
	self assert: [ storage keys includes: 'testLocalKey' ].

	storage removeItem: 'testLocalKey'.
	self assert: [ storage length = length ].
	self assert: [ ( storage item: 'testLocalKey' ) isNil ].
!
testSessionStorage
	| storage |
	storage := Window default sessionStorage.
	storage clear.
	self assert: [ storage length = 0 ].
	self assert: [ storage keys isEmpty ].
	self assert: [ ( storage key: 0 ) isNil ].
	self assert: [ ( storage item: 'key1' ) isNil ].

	storage item: 'key1' value: 'value1'.
	storage item: 'key2' value: 'value2'.
	self assert: [ storage length = 2 ].
	self assert: [ ( storage item: 'key1' ) = 'value1' ].
	self assert: [ ( storage item: 'key2' ) = 'value2' ].
	self assert: [ ( storage key: 0 ) ~= ( storage key: 1 ) ].
	self assert: [ #( 'key1' 'key2' ) includes: ( storage key: 0 ) ].
	self assert: [ #( 'key1' 'key2' ) includes: ( storage key: 1 ) ].
	self assert: [ storage keys length = 2 ].
	self assert: [ ( storage keys includes: 'key1' ) & ( storage keys includes: 'key2' ) ].
	self assert: [ ( storage key: 2 ) isNil ].

	"Overwrite existing value."
	storage item: 'key1' value: 'value3'.
	self assert: [ storage length = 2 ].
	self assert: [ ( storage item: 'key1' ) = 'value3' ].

	storage removeItem: 'key1'.
	self assert: [ storage length = 1 ].
	self assert: [ ( storage item: 'key1' ) isNil ].
	"Removing a non-existing key does nothing."
	storage removeItem: 'key1'.
	self assert: [ storage length = 1 ].

	storage clear.
	self assert: [ storage length = 0 ].
	self assert: [ ( storage item: 'key2' ) isNil ].
!
