CLASS TestKeyValue EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| keyValue |
	keyValue := KeyValue key: 'a' value: 'aValue'.
	self assert: [ keyValue class = KeyValue ].
	self assert: [ keyValue toString = '{ a, aValue }' ].
	self assert: [ keyValue key = 'a' ].
	self assert: [ keyValue value = 'aValue' ].

	keyValue key: 'b'.
	self assert: [ keyValue key = 'b' ].
	keyValue value: 'bValue'.
	self assert: [ keyValue value = 'bValue' ].
!
