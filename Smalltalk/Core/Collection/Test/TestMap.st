CLASS TestMap EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| map sum |

	map := Map new.
	map set: 'a' value: 1.
	map set: 'b' value: 2.
	map set: 'c' value: 3.

	self assert: [ map size = 3 ].
	self assert: [ ( map get: 'c' ) = 3 ].
	self assert: [ map has: 'b' ].
	self assert: [ ( map has: 'd' ) not ].

	self assert: [ map delete: 'b' ].
	self assert: [ ( map has: 'b' ) not ].

	map set: 'b' value: 22.
	self assert: [ ( map get: 'b' ) = 22 ].
	map set: 'b' value: 2.
	self assert: [ ( map get: 'b' ) = 2 ].

	self assert: [ map keys length = 3 ].
	self assert: [ ( map keys at: 0 ) = 'a' ].
	self assert: [ ( map values at: 2 ) = 2 ].

	self assert: [ ( ( map entries at: 2 ) at: 0 ) = 'b' ].
	self assert: [ ( ( map entries at: 2 ) at: 1 ) = 2 ].

	sum := 0.
	map forEach: [ :key :value | sum := sum + value ].
	self assert: [ sum = 6 ].

	map clear.
	self assert: [ map size = 0 ].
!
