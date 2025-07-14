CLASS TestFloat16Array EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	| array |

	self assert: [ Float16Array new length = 0 ].
	self assert: [ ( Float16Array new: 3 ) length = 3 ].
	self assert: [ ( Float16Array new: 3 ) last = 0 ].
	self assert: [ ( Float16Array with: 7.0 ) first = 7.0 ].
	self assert: [ ( Float16Array with: 8.0 with: 9.0 ) last = 9.0 ].

	array := Float16Array from: #( -400.0 5.0 6000.0 ).
	self assert: [ ( array at: 1 ) = 5.0 ].

!
testConversion
	| array |
	array := Float16Array from: #( -400.0 5.0 6000.0 ).

	self assert: [ array toArray = #( -400.0 5.0 6000.0 ) ].
	self assert: [ ( array entries at: 1 ) = #( 1 5.0 ) ].
	self assert: [ ( array join: ' ' ) = '-400 5 6000' ].
	self assert: [ array toString = '#( -400 5 6000 )' ].
!
testBuffer
	| array |
	array := Float16Array from: #( -400.0 5.0 6000.0 ).

	self assert: [ ( ArrayBuffer isView: array ) not ].
	self assert: [ array buffer class = ArrayBuffer ].
	self assert: [ array buffer byteLength = 6 ].
	self assert: [ ( array slice: 1 to: 2 ) first = 5.0 ].
!
testCore
	| array |

	array := Float16Array new: 3.
	self assert: [ array toArray = #( 0.0 0.0 0.0 ) ].
	self assert: [ array length = 3 ].

	self assert: [ ( array at: 0 ) = 0.0 ].
	array at: 1 put: -400.0.
	self assert: [ ( array at: 1 ) = -400.0 ].
	array at: 2 put: 6000.
	self assert: [ ( array at: 2 ) = 6000.0 ].

	array := Float16Array from: #( -400.0 5.0 6000.0 ).
	self assert: [ array length = 3 ].
	self assert: [ array toArray = #( -400.0 5.0 6000.0 ) ].
	self assert: [ array toString includes: '6000' ].

!
testSearch
	| array |
	array := Float16Array from: #( 5.0 6.0 7.0 8.0 9.0 ).

	self assert: [ ( array filter: [ :element | element % 2 = 0 ] ) toArray = #( 6.0 8.0 ) ].

	self assert: [ ( array find: [ :element | element = 8.0 ] ) = 8.0 ].
	self assert: [ ( array find: [ :element | element = 10.0 ] ) = nil ].

	self assert: [ ( array findIndex: [ :element | element = 8.0 ] ) = 3 ].
	self assert: [ ( array findIndex: [ :element | element = 10.0 ] ) = -1 ].

	self assert: [ ( array findLast: [ :element | element < 8.0 ] ) = 7.0 ].
	self assert: [ ( array findLast: [ :element | element >= 10.0 ] ) = nil ].

	self assert: [ ( array findLastIndex: [ :element | element < 8.0 ] ) = 2 ].
	self assert: [ ( array findLastIndex: [ :element | element >= 10.0 ] ) = -1 ].

	self assert: [ ( array indexOf: 6.0 ) = 1 ].
	self assert: [ ( array indexOf: 3.0 ) = -1 ].

	self assert: [ ( ( Float16Array from: #( 3.0 3.0 4.0 ) ) lastIndexOf: 3.0 ) = 1 ].
	self assert: [ ( ( Float16Array from: #( 3.0 3.0 4.0 ) ) lastIndexOf: 5.0 ) = -1 ].

	self assert: [ array includes: 8.0 ].
	self assert: [ ( array includes: 10.0 ) not ].
!
testIteration
	| array sum |
	array := #( 4.0 5.0 6.0 ).

	sum := 0.
	array do: [ :num | sum := sum + num ].
	self assert: [ sum = 15.0 ].

	self assert: [ array every: [ :element | element >= 4.0 ] ].
	self assert: [ ( array every: [ :element | element <= 5.0 ] ) not ].

	self assert: [ array some: [ :element | element > 5.0 ] ].
	self assert: [ ( array some: [ :element | element > 6.0 ] ) not ].
!
testModification
	| array |
	array := Float16Array from: #( 5.0 6.0 7.0 ).

	self assert: [ ( array map: [ :element | element squared ] ) toArray = #( 25.0 36.0 49.0 ) ].

	self assert: [ ( array reduce: [ :element1 :element2 | element1 + element2 ] ) = 18.0 ].
	self assert: [ ( array reduce: [ :element1 :element2 | element1 + element2 ] with: 100.0 ) = 118.0 ].
	self assert: [ ( array reduceRight: [ :element1 :element2 | element1 - element2 ] ) = -4.0 ].
	self assert: [ ( array reduceRight: [ :element1 :element2 | element1 - element2 ] with: 100.0 ) = 82.0 ].

	self assert: [ ( array slice: 1 ) toArray = #( 6.0 7.0 ) ].
	self assert: [ ( array slice: 0 to: 2 ) toArray = #( 5.0 6.0 ) ].

	self assert: [ ( array copy swap: 0 with: 2 ) toArray = #( 7.0 6.0 5.0 ) ].
	self assert: [ ( array copy copyWithin: 0 start: 1 end: 3 ) toArray = #( 6.0 7.0 7.0 ) ].
	self assert: [ ( array copy fill: 9.0 start: 0 end: 2 ) toArray = #( 9.0 9.0 7.0 ) ].
	self assert: [ array copy reverse toArray = #( 7.0 6.0 5.0 ) ].
	self assert: [ ( array copy set: ( Float16Array from: #( 8.0 9.0 ) ) offset: 1 ) toArray = #( 5.0 8.0 9.0 ) ].
!
testSelection
	| array |
	array := Float16Array from: #( 5.0 6.0 7.0 ).

	self assert: [ ( array subarray: 1 ) toArray = #( 6.0 7.0 ) ].
	self assert: [ ( array subarray: 1 to: 2 ) toArray = #( 6.0 ) ].
!
testSort
	self assert: [ #( 9.0 8.0 7.0 6.0 5.0 4.0 3.0 2.0 1.0 0.0 ) sort = #( 0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 ) ].
	self assert: [ #( 10.0 90.0 32.0 74.0 34.0 57.0 89.0 61.0 30.0 44.0 ) sort = #( 10.0 30.0 32.0 34.0 44.0 57.0 61.0 74.0 89.0 90.0 ) ].
!
