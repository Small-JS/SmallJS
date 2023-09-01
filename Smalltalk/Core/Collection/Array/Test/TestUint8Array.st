CLASS TestUint8Array EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	| typedArray |

	self assert: [ Uint8Array new length = 0 ].
	self assert: [ ( Uint8Array new: 3 ) length = 3 ].
	self assert: [ ( Uint8Array new: 3 ) last = 0 ].
	self assert: [ ( Uint8Array with: 7 ) first = 7 ].
	self assert: [ ( Uint8Array with: 8 with: 9 ) last = 9 ].

	typedArray := Uint8Array from: #( 4 5 6 ).
	self assert: [ ( typedArray at: 1 ) = 5 ].

!
testConversion
	| typedArray |
	typedArray := Uint8Array from: #( 4 5 6 ).

	self assert: [ typedArray toArray = #( 4 5 6 ) ].
	self assert: [ ( typedArray entries at: 1 ) = #( 1 5 ) ].
	self assert: [ ( typedArray join: ' ' ) = '4 5 6' ].
	self assert: [ typedArray toString = '#( 4 5 6 )' ].
!
testBuffer
	| typedArray |
	typedArray := Uint8Array from: #( 4 5 6 ).

	self assert: [ ( ArrayBuffer isView: typedArray ) not ].
	self assert: [ typedArray buffer class = ArrayBuffer ].
	self assert: [ typedArray buffer byteLength = 3 ].
	self assert: [ ( typedArray slice: 1 to: 2 ) first = 5 ].
!
testCore
	| typedArray1 typedArray2 |

	typedArray1 := Uint8Array new: 3.
	typedArray2 := Uint8Array from: #( 4 5 6 ).

	self assert: [ typedArray1 toArray = #( 0 0 0 ) ].
	self assert: [ typedArray2 toArray = #( 4 5 6 ) ].

	self assert: [ typedArray1 length + typedArray2 length = 6 ].
	self assert: [ typedArray2 toString = '#( 4 5 6 )' ].

	self assert: [ ( typedArray2 at: 1 ) = 5 ].
	typedArray2 at: 2 put: 7.
	self assert: [ ( typedArray2 at: 2 ) = 7 ].
	typedArray2 at: 0 put: 257.
	self assert: [ ( typedArray2 at: 0 ) = 1 ].
	typedArray2 at: 0 put: -1.
	self assert: [ ( typedArray2 at: 0 ) = 255 ].
!
testSearch
	| typedArray |
	typedArray := Uint8Array from: #( 5 6 7 8 9 ).

	self assert: [ ( typedArray filter: [ :element | element % 2 = 0 ] ) toArray = #( 6 8 ) ].

	self assert: [ ( typedArray find: [ :element | element = 8 ] ) = 8 ].
	self assert: [ ( typedArray find: [ :element | element = 10 ] ) = nil ].

	self assert: [ ( typedArray findIndex: [ :element | element = 8 ] ) = 3 ].
	self assert: [ ( typedArray findIndex: [ :element | element = 10 ] ) = -1 ].

	self assert: [ ( typedArray findLast: [ :element | element < 8 ] ) = 7 ].
	self assert: [ ( typedArray findLast: [ :element | element >= 10 ] ) = nil ].

	self assert: [ ( typedArray findLastIndex: [ :element | element < 8 ] ) = 2 ].
	self assert: [ ( typedArray findLastIndex: [ :element | element >= 10 ] ) = -1 ].

	self assert: [ ( typedArray indexOf: 6 ) = 1 ].
	self assert: [ ( typedArray indexOf: 3 ) = -1 ].

	self assert: [ ( ( Uint8Array from: #( 3 3 4 ) ) lastIndexOf: 3 ) = 1 ].
	self assert: [ ( ( Uint8Array from: #( 3 3 4 ) ) lastIndexOf: 5 ) = -1 ].

	self assert: [ typedArray includes: 8 ].
	self assert: [ ( typedArray includes: 10 ) not ].
!
testIteration
	| typedArray sum |
	typedArray := #( 4 5 6 ).

	sum := 0.
	typedArray do: [ :num | sum := sum + num ].
	self assert: [ sum = 15 ].

	self assert: [ typedArray every: [ :element | element >= 4 ] ].
	self assert: [ ( typedArray every: [ :element | element <= 5 ] ) not ].

	self assert: [ typedArray some: [ :element | element > 5 ] ].
	self assert: [ ( typedArray some: [ :element | element > 6 ] ) not ].
!
testModification
	| typedArray |
	typedArray := Uint8Array from: #( 5 6 7 ).

	self assert: [ ( typedArray map: [ :element | element squared ] ) toArray = #( 25 36 49 ) ].

	self assert: [ ( typedArray reduce: [ :element1 :element2 | element1 + element2 ] ) = 18 ].
	self assert: [ ( typedArray reduce: [ :element1 :element2 | element1 + element2 ] with: 100 ) = 118 ].
	self assert: [ ( typedArray reduceRight: [ :element1 :element2 | element1 - element2 ] ) = -4 ].
	self assert: [ ( typedArray reduceRight: [ :element1 :element2 | element1 - element2 ] with: 100 ) = 82 ].

	self assert: [ ( typedArray slice: 1 ) toArray = #( 6 7 ) ].
	self assert: [ ( typedArray slice: 0 to: 2 ) toArray = #( 5 6 ) ].

	self assert: [ ( typedArray copy swap: 0 with: 2 ) toArray = #( 7 6 5 ) ].
	self assert: [ ( typedArray copy copyWithin: 0 start: 1 end: 3 ) toArray = #( 6 7 7 ) ].
	self assert: [ ( typedArray copy fill: 9 start: 0 end: 2 ) toArray = #( 9 9 7 ) ].
	self assert: [ typedArray copy reverse toArray = #( 7 6 5 ) ].
	self assert: [ ( typedArray copy set: ( Uint8Array from: #( 8 9 ) ) offset: 1 ) toArray = #( 5 8 9 ) ].
!
testSelection
	| typedArray |
	typedArray := Uint8Array from: #( 5 6 7 ).

	self assert: [ ( typedArray subarray: 1 ) toArray = #( 6 7 ) ].
	self assert: [ ( typedArray subarray: 1 to: 2 ) toArray = #( 6 ) ].
!
testSort
	self assert: [ #( 9 8 7 6 5 4 3 2 1 0 ) sort = #( 0 1 2 3 4 5 6 7 8 9 ) ].
	self assert: [ #( 10 90 32 74 34 57 89 61 30 44 ) sort = #( 10 30 32 34 44 57 61 74 89 90 ) ].
!
