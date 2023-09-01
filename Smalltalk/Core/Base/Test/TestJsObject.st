CLASS TestJsObject EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| jsObject |

	self assert: [ ( JsObject fromJs: INLINE 'null' ) isNull ].
	self assert: [ ( JsObject fromJs: INLINE 'undefined' ) isNull ].

	jsObject := JsObject fromJs: INLINE '{
		name: "John Doe", age: 50, pi: 3.14, itIs: true, empty: null,
		things: [ 1, "b", 3.3 ], nested: { inHere: "I am in here" } }'.

	self assert: [ ( jsObject atJsProperty: 'name' ) = 'John Doe' ].
	self assert: [ ( jsObject atJsProperty: 'age' ) = 50 ].
	self assert: [ ( jsObject atJsProperty: 'pi' ) = 3.14 ].
	self assert: [ ( jsObject atJsProperty: 'itIs' ) = true ].
	self assert: [ ( jsObject atJsProperty: 'empty' ) = nil ].
	self assert: [ ( ( jsObject atJsProperty: 'things' ) at: 1 ) = 'b' ].
	self assert: [ ( ( jsObject atJsProperty: 'nested' ) atProperty: 'inHere' ) = 'I am in here' ].
!
testJson
	| object |

	object := JsObject parse: '{ "a": 1, "b": { "b1": 21 }, "c": [ 31, 32 ] }'.

	self assert: [ ( object atProperty: 'a' ) = 1 ].
	self assert: [ ( ( object atProperty: 'b' ) atProperty: 'b1' ) = 21 ].
	self assert: [ ( object atProperty: 'c' ) = #( 31 32 ) ].
!
