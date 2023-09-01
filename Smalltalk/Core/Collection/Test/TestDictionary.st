CLASS TestDictionary EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| dict string a |
	a := Array new: 2.
	dict := Dictionary new.
	dict at: 'a' put: 'aValue'.
	dict at: 'b' put: 'bValue'.
	dict at: 'c' put: 'cValue'.

	self assert: [ dict size = 3 ].
	self assert: [ ( dict at: 'b' ifAbsent: [ nil ] ) = 'bValue' ].
	self assert: [ ( dict at: 'd' ifAbsent: [ nil ] ) = nil ].

	dict removeAt: 'b'.
	self assert: [ dict size = 2 ].
	string := ''.
	dict do: [ :key :value |
		string := string, key, value ].
	self assert: [ string = 'aaValueccValue' ].
!
