CLASS TestSet EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| set set2 set3 string |

	set := Set new.
	set add: 'a'.
	set add: 'b'.
	set add: 'c'.
	self assert: [ set size = 3 ].
	self assert: [ set values = #( 'a' 'b' 'c' ) ].
	self assert: [ set keys = set values ].
	self assert: [ set entries = #( #( 'a' 'a' ) #( 'b' 'b' ) #( 'c' 'c' ) ) ].
	self assert: [ set toString = 'Set( a b c )' ].

	self assert: [ ( set find: 'b' ) = 'b' ].
	self assert: [ ( set find: 'd' ) isNil ].

	self assert: [ set has: 'b' ].
	self assert: [ ( set has: 'd' ) not ].

	string := ''.
	set forEach: [ :value | string := string + value ].
	self assert: [ string = 'abc' ].

	set2 := Set new: #( 'c' 'd' ).
	self assert: [ ( set difference: set2 ) values = #( 'a' 'b' ) ].
	self assert: [ ( set intersection: set2 ) values = #( 'c' ) ].
	self assert: [ ( set symmetricDifference: set2 ) values = #( 'a' 'b' 'd' ) ].
	self assert: [ ( set union: set2 ) values = #( 'a' 'b' 'c' 'd' ) ].

	set3 := Set new: #( 'e' ).
	self assert: [ set isDisjointFrom: set3 ].
	self assert: [ ( set isDisjointFrom: set2 ) not ].

	set3 := Set new: #( 'a' 'b' ).
	self assert: [ set3 isSubsetOf: set ].
	self assert: [ ( set isSubsetOf: set3 ) not ].
	self assert: [ set isSupersetOf: set3 ].
	self assert: [ ( set3 isSupersetOf: set2 ) not ].

	set delete: 'b'.
	self assert: [ set size = 2 ].
	self assert: [ set values = #( 'a' 'c' ) ].
	set clear.
	self assert: [ set size = 0 ].
!

