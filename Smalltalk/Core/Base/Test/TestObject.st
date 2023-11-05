CLASS TestObject EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| object |
	object := Object new.

	self assert: [ object isMemberOf: Object ].
	self assert: [ String new isKindOf: Object ].
	self assert: [ self isKindOf: Test ].

	self assert: [ object = object ].
	self assert: [ object == object ].
	self assert: [ object ~= Object new ].

	self assert: [ true ].
	self assertError: [ object error: 'My error.' ].
	self assertError: [ object subclassResponsibility ].
	self assertError: [ object halt ].

	self assert: [ object isNil not ].
	self assert: [ object notNil ].
	self assert: [ object yourself = object ].
!
testConversion
	| object js |
	object := Object new.

	self assert: [ object toString = 'a Object' ].
	"JS cannot compare objects for value quality, so use toJson for implecitly testing toJs."
	self assert: [ object toJson = '{}' ].
!
testPerform
	| object |
	object := Object new.

	self assert: [ ( object perform: 'toString' ) = 'a Object' ].
	self assert: [ object perform: '=' with: object ].
	self assert: [ ( 'abc' perform: 'substring:to:' with: 1 with: 2 ) = 'b' ].
	self assert: [ ( Date perform: 'year:month:day:' with: 1980 with: 2 with: 28 ) year = 1980 ].
!
testAssignment
	| object1 object2 |

	object1 := 7.
	self assert: [ object1 = 7 ].

	object2 := 'a'.
	self assert: [ object2 = 'a' ].

	object1 := object2 := 2.0.
	self assert: [ ( object1 = 2.0 ) & ( object2 = 2.0 ) ].
!
testVariables
	| point |
	point := ( 2 @ 3 ).

	self assert: [ point ownPropertyNames = #( 'x' 'y' ) ].
	self assert: [ ( point atProperty: 'x' ) = 2 ].
	self assert: [ ( point atProperty: 'z' ) isNil ].

	point atProperty: 'y' put: 4.
	self assert: [ ( point atProperty: 'y' ) = 4 ].
!
