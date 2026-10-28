CLASS TestQObject EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| object |
	object := QObject new.
	self assert: [ object jsClassName = 'QObject' ].

	object setObjectName: 'myObjectName'.
	self assert: [ object objectName = 'myObjectName' ].
!
testId
	| object1 object2 |
	object1 := QObject new.
	object2 := QObject new.
	self assert: [ object1 id class = Integer ].
	self assert: [ object1 id = object1 id ].
	self assert: [ object1 id ~= object2 id ].
!
testInherits
	| object |
	object := QObject new.
	self assert: [ object inherits: 'QObject' ].
	self assert: [ ( object inherits: 'QWidget' ) not ].
	self assert: [ QWidget new inherits: 'QObject' ].
!
testProperty
	| object |
	object := QObject new.

	"Dynamic properties are set, but setProperty: answers false."
	self assert: [ ( object setProperty: 'myString' value: 'abc' ) not ].
	self assert: [ ( object property: 'myString' ) toString = 'abc' ].
	object setProperty: 'myInt' value: 42.
	self assert: [ ( object property: 'myInt' ) toInt = 42 ].
	object setProperty: 'myDouble' value: 1.5.
	self assert: [ ( object property: 'myDouble' ) toDouble = 1.5 ].
	object setProperty: 'myBool' value: true.
	self assert: [ ( object property: 'myBool' ) toBool ].
	object setProperty: 'myList' value: #( 'a' 'b' ).
	self assert: [ ( object property: 'myList' ) toStringList = #( 'a' 'b' ) ].

	"Declared Qt property."
	self assert: [ object setProperty: 'objectName' value: 'myName' ].
	self assert: [ object objectName = 'myName' ].
!
testParent
	| parent child1 child2 |
	parent := QObject new setObjectName: 'parent'.
	child1 := QObject new setObjectName: 'child1'.
	child2 := QObject new setObjectName: 'child2'.
	self assert: [ child1 parent isNil ].
	self assert: [ parent children isEmpty ].

	child1 setParent: parent.
	child2 setParent: parent.
	self assert: [ child1 parent = parent ].
	self assert: [ parent children length = 2 ].
	self assert: [ ( parent children map: [ :child | child objectName ] ) = #( 'child1' 'child2' ) ].

	child1 setParent: nil.
	self assert: [ child1 parent isNil ].
	self assert: [ parent children length = 1 ].

	"Deleting a child removes it from its parent."
	child2 delete.
	self assert: [ parent children isEmpty ].
!
testEventListener
	| object count block |
	object := QObject new.
	count := 0.
	block := [ count := count + 1 ].

	object addEventListener: 'objectNameChanged' then: block.
	object setObjectName: 'name1'.
	self assert: [ count = 1 ].

	"Adding the same block again does nothing."
	object addEventListener: 'objectNameChanged' then: block.
	self assert: [ object eventIds length = 1 ].
	object setObjectName: 'name2'.
	self assert: [ count = 2 ].

	object removeEventListener: 'objectNameChanged' then: block.
	self assert: [ object eventIds isEmpty ].
	object setObjectName: 'name3'.
	self assert: [ count = 2 ].
!
testTimer
	| object timerId |
	object := QObject new.
	timerId := object startTimer: 1000.
	self assert: [ timerId > 0 ].
	object killTimer: timerId.

	timerId := object startTimer: 1000 type: QObject preciseTimer.
	self assert: [ timerId > 0 ].
	object killTimer: timerId.
!
