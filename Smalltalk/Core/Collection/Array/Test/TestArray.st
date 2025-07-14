CLASS TestArray EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCore
	| array1 array2 value |

	array1 := Array new: 3.
	array2 := #( 4 5 6 ).
	value := 7.

	self assert: [ array1 length + array2 length = 6 ].
	self assert: [ #( 1 'a' 3.14 value ( 4 + 5 ) ) toString = '#( 1 a 3.14 7 9 )' ].
	self assert: [ ( #( 1 2 3 ) join: ',' ) = '1,2,3' ].

	self assert: [ array1 = #( nil nil nil ) ].
	self assert: [ array2 = #( 4 5 6 ) ].
	self assert: [ ( array2 at: 1 ) = 5 ].
	array2 at: 2 put: 7.
	self assert: [ ( array2 at: 2 ) = 7 ].
	array2 add: 8.
	self assert: [ array2 length = 4 ].

	self assert: [ ( #( 1 2 3 ) at: 1 with: 9 ) = #( 1 9 3 ) ].

	self assert: [ #( 1 2 ) , #( 3 4 ) = #( 1 2 3 4 ) ].
	self assert: [ array2 pop = 8 ].
	self assertError: [ Array new pop ].

	array1 := #( 1 2 ).
	array2 := array1 copy.
	self assert: [ array1 = array2 ].
	array2 add: 3.
	self assert: [ array1 ~= array2 ].
!
testCreation
	| array jsArray |

	self assert: [ Array new length = 0 ].
	self assert: [ ( Array new: 3 ) length = 3 ].
	self assert: [ ( Array with: 7 ) first = 7 ].
	self assert: [ ( Array with: 8 with: 9 ) last = 9 ].

	array := Array fromJs: INLINE '[ 4, 5, 6 ]'.
	"Array now contains JS numbers, not ST numbers."
	self assert: [ ( Integer fromJs: ( array at: 1 ) ) = 5 ].

	array := Array fromJs: INLINE '[ 6, 7, 8 ]' elementClass: Integer.
	self assert: [ ( array at: 1 ) = 7 ].

	array := Array fromJs: INLINE '[ 10, 11, 12 ]' elementConverter:
		[ :element | ( Integer fromJs: element ) * 10 ].
	self assert: [ ( array at: 1 ) = 110 ].

	jsArray := ( Array with: 13 with: 'a' ) toJs.
	self assert: [ ( Integer fromJs: INLINE 'jsArray[ 0 ]' ) = 13 ].
	self assert: [ ( String fromJs: INLINE 'jsArray[ 1 ]' ) = 'a' ].
!
testSearch
	| array |
	array := #( 5 6 7 8 9 ).

	self assert: [ ( array filter: [ :element | element % 2 = 0 ] ) = #( 6 8 ) ].
	self assert: [ ( array find: [ :element | element = 8 ] ) = 8 ].
	self assert: [ ( array find: [ :element | element = 10 ] ) = nil ].
	self assert: [ ( array findIndex: [ :element | element = 8 ] ) = 3 ].
	self assert: [ ( array findIndex: [ :element | element = 10 ] ) = -1 ].
	self assert: [ ( array findLastIndex: [ :element | element % 2 = 0 ] ) = 3 ].
	self assert: [ ( array findLastIndex: [ :element | element >= 10 ] ) = -1 ].
	self assert: [ ( array indexOf: 6 ) = 1 ].
	self assert: [ ( array indexOf: 3 ) = -1 ].
	self assert: [ array includes: 8 ].
	self assert: [ ( array includes: 10 ) not ].
!
testModify
	| array |
	array := #( 5 6 7 ).

	self assert: [ ( array map: [ :element | element squared ] ) = #( 25 36 49 ) ].
	self assert: [ ( array reduce: [ :element1 :element2 | element1 + element2 ] ) = 18 ].
	self assert: [ ( array reduce: [ :element1 :element2 | element1 + element2 ] with: 100 ) = 118 ].
	self assert: [ ( array reduceRight: [ :element1 :element2 | element1 - element2 ] ) = -4 ].
	self assert: [ ( array reduceRight: [ :element1 :element2 | element1 - element2 ] with: 100 ) = 82 ].
	self assert: [ array copy reverse = #( 7 6 5 ) ].
	self assert: [ array toReversed = #( 7 6 5 ) ].
	self assert: [ ( array shift = 5 ) & ( array = #( 6 7 ) ) ].
	self assert: [ ( array unshift: 5 ) = #( 5 6 7 ) ].
	self assert: [ ( array slice: 1 ) = #( 6 7 ) ].
	self assert: [ ( array slice: 0 to: 2 ) = #( 5 6 ) ].
	self assert: [ ( array copy splice: 1 ) = #( 5 ) ].
	self assert: [ ( array copy splice: 1 count: 1 ) = #( 5 7 ) ].
	self assert: [ ( array toSpliced: 1 ) = #( 5 ) ].
	self assert: [ ( array toSpliced: 1 count: 1 ) = #( 5 7 ) ].
	self assert: [ ( array copy swap: 0 with: 2 ) = #( 7 6 5 ) ].
	self assert: [ ( #( 4 5 6 ) removeAt: 1 ) = #( 4 6 ) ].
	self assert: [ ( array copy copyWithin: 0 start: 1 end: 3 ) = #( 6 7 7 ) ].
!
testIteration
	| array sum |
	array := #( 4 5 6 ).
	sum := 0.
	array do: [ :num | sum := sum + num ].
	self assert: [ sum = 15 ].

	self assert: [ array every: [ :element | element > 3 ] ].
	self assert: [ ( array every: [ :element | element <= 5 ] ) not ].
	self assert: [ array some: [ :element | element > 5 ] ].
	self assert: [ ( array some: [ :element | element > 6 ] ) not ].

!
testSort
	| reverseCompareBlock |
	self assert: [ #( 9 8 7 6 5 4 3 2 1 0 ) sort = #( 0 1 2 3 4 5 6 7 8 9 ) ].
	self assert: [ #( 10 90 32 74 34 57 89 61 32 44 ) sort = #( 10 32 32 34 44 57 61 74 89 90 ) ].

	self assert: [ #( 9 8 7 6 5 4 3 2 1 0 ) toSorted = #( 0 1 2 3 4 5 6 7 8 9 ) ].
	self assert: [ #( 10 90 32 74 34 57 89 61 32 44 ) toSorted = #( 10 32 32 34 44 57 61 74 89 90 ) ].

	reverseCompareBlock := [ :a :b | b compare: a ].
	self assert: [ ( #( 10 90 32 74 34 57 89 61 32 44 ) sortWith: reverseCompareBlock ) = #( 90 89 74 61 57 44 34 32 32 10 ) ].
	self assert: [ ( #( 10 90 32 74 34 57 89 61 32 44 ) toSortedWith: reverseCompareBlock ) = #( 90 89 74 61 57 44 34 32 32 10 ) ].
!
