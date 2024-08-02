CLASS TestDomPointReadOnly EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| domPoint domPoint2 jsObject |

	domPoint := DomPointReadOnly x: 1 y: 2.
	self assert: [ domPoint x = 1 ].
	self assert: [ domPoint y = 2 ].

	domPoint := DomPointReadOnly x: 3 y: 4 z: 5.
	self assert: [ domPoint x = 3 ].
	self assert: [ domPoint y = 4 ].
	self assert: [ domPoint z = 5 ].

	domPoint := DomPointReadOnly x: 6 y: 7 z: 8 w: 9.
	self assert: [ domPoint x = 6 ].
	self assert: [ domPoint y = 7 ].
	self assert: [ domPoint z = 8 ].
	self assert: [ domPoint w = 9 ].

	jsObject := domPoint toJson.
	self assert: [ ( jsObject atJsProperty: 'x' ) = 6 ].
	self assert: [ ( jsObject atJsProperty: 'y' ) = 7 ].
	self assert: [ ( jsObject atJsProperty: 'z' ) = 8 ].
	self assert: [ ( jsObject atJsProperty: 'w' ) = 9 ].

	domPoint2 := DomPointReadOnly fromPoint: domPoint.
	self assert: [ domPoint2 x = 6 ].
	self assert: [ domPoint2 y = 7 ].
	self assert: [ domPoint2 z = 8 ].
	self assert: [ domPoint2 w = 9 ].
!
