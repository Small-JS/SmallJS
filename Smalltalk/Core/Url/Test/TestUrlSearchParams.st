CLASS TestUrlSearchParams EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	| params record |
	params := UrlSearchParams new.
	self assert: [ params class = UrlSearchParams ].
	self assert: [ params jsClassName = 'URLSearchParams' ].
	self assert: [ params size = 0 ].
	self assert: [ params toString = '' ].

	params := UrlSearchParams init: '?a=1&b=2&a=3'.
	self assert: [ params size = 3 ].
	self assert: [ params toString = 'a=1&b=2&a=3' ].
	self assert: [ ( UrlSearchParams init: 'a=1' ) toString = 'a=1' ].

	params := UrlSearchParams init: #( #( 'a' '1' ) #( 'b' '2' ) ).
	self assert: [ params toString = 'a=1&b=2' ].

	record := JsObject newEmpty.
	record atJsProperty: 'x' put: '7'.
	params := UrlSearchParams init: record.
	self assert: [ params toString = 'x=7' ].
!
testAccessing
	| params |
	params := UrlSearchParams init: 'a=1&b=2&a=3'.
	self assert: [ ( params get: 'a' ) = '1' ].
	self assert: [ ( params get: 'z' ) = nil ].
	self assert: [ ( params getAll: 'a' ) = #( '1' '3' ) ].
	self assert: [ ( params getAll: 'z' ) = #() ].
	self assert: [ params has: 'b' ].
	self assert: [ ( params has: 'z' ) not ].
	self assert: [ params has: 'a' value: '3' ].
	self assert: [ ( params has: 'a' value: '2' ) not ].
!
testModifying
	| params |
	params := UrlSearchParams new.
	params append: 'a' value: '1'.
	params append: 'a' value: '2'.
	params append: 'n' value: 5.
	self assert: [ params toString = 'a=1&a=2&n=5' ].

	"set: replaces all existing values."
	params set: 'a' value: 'new'.
	self assert: [ params toString = 'a=new&n=5' ].

	params append: 'a' value: 'other'.
	params delete: 'a' value: 'new'.
	self assert: [ params toString = 'n=5&a=other' ].

	params delete: 'a'.
	self assert: [ params toString = 'n=5' ].

	"Values are encoded."
	params set: 'q' value: 'a b&c'.
	self assert: [ params toString = 'n=5&q=a+b%26c' ].
	self assert: [ ( params get: 'q' ) = 'a b&c' ].
!
testSort
	| params |
	params := UrlSearchParams init: 'c=1&a=2&b=3&a=1'.
	params sort.
	self assert: [ params toString = 'a=2&a=1&b=3&c=1' ].
!
testIterating
	| params |
	params := UrlSearchParams init: 'a=1&b=2&a=3'.
	self assert: [ params keys = #( 'a' 'b' 'a' ) ].
	self assert: [ params values = #( '1' '2' '3' ) ].
	self assert: [ params entries = #( #( 'a' '1' ) #( 'b' '2' ) #( 'a' '3' ) ) ].
!
