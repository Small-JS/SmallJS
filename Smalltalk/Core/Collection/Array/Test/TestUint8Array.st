CLASS TestUint8Array EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	| array |

	self assert: [ Uint8Array new length = 0 ].
	self assert: [ ( Uint8Array new: 3 ) length = 3 ].
	self assert: [ ( Uint8Array new: 3 ) last = 0 ].
	self assert: [ ( Uint8Array with: 7 ) first = 7 ].
	self assert: [ ( Uint8Array with: 8 with: 9 ) last = 9 ].

	array := Uint8Array from: #( 4 5 6 ).
	self assert: [ ( array at: 1 ) = 5 ].

!
testConversion
	| array |
	array := Uint8Array from: #( 4 5 6 ).

	self assert: [ array toArray = #( 4 5 6 ) ].
	self assert: [ ( array entries at: 1 ) = #( 1 5 ) ].
	self assert: [ ( array join: ' ' ) = '4 5 6' ].
	self assert: [ array toString = '#( 4 5 6 )' ].

	self assert: [ array toHex = '040506' ].
	self assert: [ ( Uint8Array fromHex: '4a4b4c' ) toArray = #( 74 75 76 ) ].
!
testCoding
	| array |
	array := Uint8Array encodeFromString: 'ABC'.
	self assert: [ array toArray = #( 65 66 67 ) ].
	self assert: [ array decodeToString = 'ABC' ].
!
testBuffer
	| array |
	array := Uint8Array from: #( 4 5 6 ).

	self assert: [ ( ArrayBuffer isView: array ) not ].
	self assert: [ array buffer class = ArrayBuffer ].
	self assert: [ array buffer byteLength = 3 ].
	self assert: [ ( array slice: 1 to: 2 ) first = 5 ].
!
testCore
	| array1 array2 |

	array1 := Uint8Array new: 3.
	array2 := Uint8Array from: #( 4 5 6 ).

	self assert: [ array1 toArray = #( 0 0 0 ) ].
	self assert: [ array2 toArray = #( 4 5 6 ) ].

	self assert: [ array1 length + array2 length = 6 ].
	self assert: [ array2 toString = '#( 4 5 6 )' ].

	self assert: [ ( array2 at: 1 ) = 5 ].
	array2 at: 2 put: 7.
	self assert: [ ( array2 at: 2 ) = 7 ].
	array2 at: 0 put: 257.
	self assert: [ ( array2 at: 0 ) = 1 ].
	array2 at: 0 put: -1.
	self assert: [ ( array2 at: 0 ) = 255 ].
!
testSearch
	| array |
	array := Uint8Array from: #( 5 6 7 8 9 ).

	self assert: [ ( array filter: [ :element | element % 2 = 0 ] ) toArray = #( 6 8 ) ].

	self assert: [ ( array find: [ :element | element = 8 ] ) = 8 ].
	self assert: [ ( array find: [ :element | element = 10 ] ) = nil ].

	self assert: [ ( array findIndex: [ :element | element = 8 ] ) = 3 ].
	self assert: [ ( array findIndex: [ :element | element = 10 ] ) = -1 ].

	self assert: [ ( array findLast: [ :element | element < 8 ] ) = 7 ].
	self assert: [ ( array findLast: [ :element | element >= 10 ] ) = nil ].

	self assert: [ ( array findLastIndex: [ :element | element < 8 ] ) = 2 ].
	self assert: [ ( array findLastIndex: [ :element | element >= 10 ] ) = -1 ].

	self assert: [ ( array indexOf: 6 ) = 1 ].
	self assert: [ ( array indexOf: 3 ) = -1 ].

	self assert: [ ( ( Uint8Array from: #( 3 3 4 ) ) lastIndexOf: 3 ) = 1 ].
	self assert: [ ( ( Uint8Array from: #( 3 3 4 ) ) lastIndexOf: 5 ) = -1 ].

	self assert: [ array includes: 8 ].
	self assert: [ ( array includes: 10 ) not ].
!
testIteration
	| array sum |
	array := #( 4 5 6 ).

	sum := 0.
	array do: [ :num | sum := sum + num ].
	self assert: [ sum = 15 ].

	self assert: [ array every: [ :element | element >= 4 ] ].
	self assert: [ ( array every: [ :element | element <= 5 ] ) not ].

	self assert: [ array some: [ :element | element > 5 ] ].
	self assert: [ ( array some: [ :element | element > 6 ] ) not ].
!
testModification
	| array |
	array := Uint8Array from: #( 5 6 7 ).

	self assert: [ ( array map: [ :element | element squared ] ) toArray = #( 25 36 49 ) ].

	self assert: [ ( array reduce: [ :element1 :element2 | element1 + element2 ] ) = 18 ].
	self assert: [ ( array reduce: [ :element1 :element2 | element1 + element2 ] with: 100 ) = 118 ].
	self assert: [ ( array reduceRight: [ :element1 :element2 | element1 - element2 ] ) = -4 ].
	self assert: [ ( array reduceRight: [ :element1 :element2 | element1 - element2 ] with: 100 ) = 82 ].

	self assert: [ ( array slice: 1 ) toArray = #( 6 7 ) ].
	self assert: [ ( array slice: 0 to: 2 ) toArray = #( 5 6 ) ].

	self assert: [ ( array copy swap: 0 with: 2 ) toArray = #( 7 6 5 ) ].
	self assert: [ ( array copy copyWithin: 0 start: 1 end: 3 ) toArray = #( 6 7 7 ) ].
	self assert: [ ( array copy fill: 9 start: 0 end: 2 ) toArray = #( 9 9 7 ) ].
	self assert: [ array copy reverse toArray = #( 7 6 5 ) ].
	self assert: [ ( array copy set: ( Uint8Array from: #( 8 9 ) ) offset: 1 ) toArray = #( 5 8 9 ) ].
!
testSelection
	| array |
	array := Uint8Array from: #( 5 6 7 ).

	self assert: [ ( array subarray: 1 ) toArray = #( 6 7 ) ].
	self assert: [ ( array subarray: 1 to: 2 ) toArray = #( 6 ) ].
!
testSort
	self assert: [ #( 9 8 7 6 5 4 3 2 1 0 ) sort = #( 0 1 2 3 4 5 6 7 8 9 ) ].
	self assert: [ #( 10 90 32 74 34 57 89 61 30 44 ) sort = #( 10 30 32 34 44 57 61 74 89 90 ) ].
!
