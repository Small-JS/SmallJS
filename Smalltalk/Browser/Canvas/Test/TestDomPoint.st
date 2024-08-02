CLASS TestDomPoint EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
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
