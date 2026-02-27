CLASS TestDictionary EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| dict string array |
	dict := Dictionary new.
	dict at: 'a' put: 'aValue'.
	dict at: 'b' put: 'bValue'.
	dict at: 'c' put: 'xValue'.
	"Replace value at key 'c'"
	dict at: 'c' put: 'cValue'.

	self assert: [ dict toString = 'Dictionary( { a, aValue } { b, bValue } { c, cValue } )' ].

	self assert: [ dict size = 3 ].
	self assert: [ dict keyValues first key = 'a' ].

	self assert: [ dict has: 'a' ].
	self assert: [ ( dict find: 'a' ) key = 'a' ].

	self assert: [ ( dict at: 'a' ) = 'aValue' ].
	self assertError: [ dict at: 'z' ].
	self assert: [ ( dict at: 'b' ifAbsent: [ nil ] ) = 'bValue' ].
	self assert: [ ( dict at: 'z' ifAbsent: [ nil ] ) = nil ].

	dict removeAt: 'b'.
	self assert: [ dict size = 2 ].

	string := ''.
	dict do: [ :key :value |
		string := string, key, value ].
	self assert: [ string = 'aaValueccValue' ].

	dict clear.
	self assert: [ dict size = 0 ].

	array := #( #( 'a' 1 ) #( 'b' 2 ) ).
	dict := Dictionary fromArray: array.
	self assert: [ dict size = 2 ].
	self assert: [ ( dict at: 'a' ) = 1 ].
	self assert: [ ( dict at: 'b' ) = 2 ].

	array := dict toArray.
	self assert: [  array = #( #( 'a' 1 ) #( 'b' 2 ) ) ]
!
