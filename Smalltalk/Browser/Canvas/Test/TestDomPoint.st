CLASS TestDomPoint EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

testReadonly
	| domPoint domPoint2 jsObject |

	domPoint := DomPoint x: 1 y: 2.
	self assert: [ domPoint x = 1 ].
	self assert: [ domPoint y = 2 ].

	domPoint := DomPoint x: 3 y: 4 z: 5.
	self assert: [ domPoint x = 3 ].
	self assert: [ domPoint y = 4 ].
	self assert: [ domPoint z = 5 ].

	domPoint := DomPoint x: 6 y: 7 z: 8 w: 9.
	self assert: [ domPoint x = 6 ].
	self assert: [ domPoint y = 7 ].
	self assert: [ domPoint z = 8 ].
	self assert: [ domPoint w = 9 ].

	jsObject := domPoint toJson.
	self assert: [ ( jsObject atJsProperty: 'x' ) = 6 ].
	self assert: [ ( jsObject atJsProperty: 'y' ) = 7 ].
	self assert: [ ( jsObject atJsProperty: 'z' ) = 8 ].
	self assert: [ ( jsObject atJsProperty: 'w' ) = 9 ].

	domPoint2 := domPoint copy.
	self assert: [ domPoint2 x = 6 ].
	self assert: [ domPoint2 y = 7 ].
	self assert: [ domPoint2 z = 8 ].
	self assert: [ domPoint2 w = 9 ].
!

testMutable
	| domPoint domPoint2 |

	domPoint := DomPoint x: 0 y: 0.
	domPoint x: 1.
	self assert: [ domPoint x = 1 ].
	domPoint y: 2.
	self assert: [ domPoint y = 2 ].

	domPoint := DomPoint x: 0 y: 0 z: 0.
	domPoint x: 3.
	self assert: [ domPoint x = 3 ].
	domPoint y: 4.
	self assert: [ domPoint y = 4 ].
	domPoint z: 5.
	self assert: [ domPoint z = 5 ].

	domPoint := DomPoint x: 0 y: 0 z: 0 w: 0.
	domPoint x: 6.
	self assert: [ domPoint x = 6 ].
	domPoint y: 7.
	self assert: [ domPoint y = 7 ].
	domPoint z: 8.
	self assert: [ domPoint z = 8 ].
	domPoint w: 9.
	self assert: [ domPoint w = 9 ].
!
