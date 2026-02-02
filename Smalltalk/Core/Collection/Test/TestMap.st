CLASS TestMap EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| map sum |

	map := Map new.
	self assert: [ map class = Map ].

	map set: 'a' value: 1.
	map set: 'b' value: 2.
	map set: 'c' value: 9.
	"Replace value at key 'c'"
	map set: 'c' value: 3.

	self assert: [ map size = 3 ].
	self assert: [ ( map get: 'c' ) = 3 ].
	self assert: [ ( map get: 'z' ) = nil ].
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
	map forEach: [ :key :value |
		self assert: [ #( 'a' 'b' 'c' ) includes: key ].
		self assert: [ value > 0 ].
		sum := sum + value ].
	self assert: [ sum = 6 ].

	map clear.
	self assert: [ map size = 0 ].
!
testGroupBy
	| groupBlock map v |
	groupBlock := [ :element | element % 2 = 0 ifTrue: [ 'even' ] ifFalse: [ 'odd' ] ].
	map := Map group: #( 1 2 3 4 5 ) by: groupBlock.
	self assert: [ map size = 2 ].
	v := map get: 'even'.
	self assert: [ ( map get: 'even' ) = #( 2 4 ) ].
	self assert: [ ( map get: 'odd' ) = #( 1 3 5 ) ].
!
