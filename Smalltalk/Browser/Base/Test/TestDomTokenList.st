CLASS TestDomTokenList EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
test
	| paragraph domTokenList |

	self assertError: [ DomTokenList new ].

	paragraph := Document default createElement: 'p'.
	domTokenList := paragraph classList.
	self assert: [ domTokenList class = DomTokenList ].

	domTokenList add: 'a'; add: 'b'; add: 'c'.
	self assert: [ domTokenList length = 3 ].
	self assert: [ domTokenList value = 'a b c' ].
	self assert: [ domTokenList contains: 'b' ].
	self assert: [ domTokenList entries = #( '0,a' '1,b' '2,c' ) ].
	self assert: [ ( domTokenList item: 1 ) = 'b' ].
	self assert: [ domTokenList keys last = 2 ].

	domTokenList remove: 'b'.
	self assert: [ ( domTokenList contains: 'b' ) not ].

	domTokenList replace: 'c' with: 'd'.
	self assert: [ domTokenList contains: 'd' ].

	domTokenList toggle: 'd'.
	self assert: [ ( domTokenList contains: 'd' ) not ].
	self assert: [ domTokenList values = #( 'a' ) ].

	self assertError: [ domTokenList supports: 'some-new-feature' ].
!
