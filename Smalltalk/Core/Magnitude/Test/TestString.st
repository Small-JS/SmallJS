CLASS TestString EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ String new = '' ].
	self assert: [ ( String fromJs: INLINE '"a"' ) = 'a' ].
	self assert: [ ( String fromCharacter: $A ) = 'A' ].
	self assert: [ ( String fromCharCode: 66 ) = 'B' ].
	self assert: [ ( ( String newline ) at: 0 ) code = 10 ].
	self assert: [ 'a' toString = 'a' ].
!
testConvertion
	self assert: [ '42' toInteger = 42 ].
	self assert: [ '3.14' toFloat = 3.14 ].
!
testAccessing
	self assert: [ 'abcd' length = 4 ].
	self assert: [ ( 'abc' at: 1 ) = $b ].
	self assertError: [ 'abc' at: 10 ].
	self assert: [ ( 'azc' at: 1 put: $b ) = 'abc' ].
!
testRegularExpressions
	self assert: [ ( 'This is It!' match: '[A-Z].' flags: 'g' ) = #( 'Th' 'It' ) ].
	self assert: [ ( 'This is It!' search: '[A-I].' ) = 8 ].
!
testIteration
	| sum |
	sum := 0.
	'ABC' do: [ :char |
		sum := sum + char code ].
	self assert: [ sum = 198 ].
!
testSearching
	self assert: [ 'abcde' includes: 'bc' ].
	self assert: [ ( 'abcde' includes: 'bc' from: 3 ) not ].
	self assert: [ 'abcde' startsWith: 'abc' ].
	self assert: [ 'abcde' endsWith: 'de' ].
	self assert: [ ( 'abcde' indexOf: 'cd' ) = 2 ].
	self assert: [ ( 'abcabcabc' indexOf: 'abc' from: 1 ) = 3 ].
	self assert: [ ( 'abcabcabc' lastIndexOf: 'abc' ) = 6 ].
	self assert: [ ( 'abcabcabc' lastIndexOf: 'abcd' ) = -1 ].
	self assert: [ ( 'abcabcabc' lastIndexOf: 'abc' from: 4 ) = 3 ].
!
testComparisons
	self assert: [ 'aa', 'bb' = 'aabb' ].
	self assert: [ 'aa' ~= 'bb' ].
	self assert: [ 'a' ~= 1 ].
	self assert: [ 'a' ~= Object new ].

	self assert: [ 'a' < 'b' ].
	self assert: [ 'a' <= 'a' ].
	self assert: [ 'b' > 'a' ].
	self assert: [ 'b' >= 'b' ].

	self assert: [ ( 'a' localeCompare: 'b' ) = -1 ].
!
testManipulation
	self assert: [ 'aa', 'bb' = 'aabb' ].
	self assert: [ 'cc' + 'dd' = 'ccdd' ].
	self assert: [ ( 'de' concat: 'f' ) = 'def' ].
	self assert: [ ( 'aabb' substring: 1 ) = 'abb' ].
	self assert: [ ( 'aabb' substring: 1 to: 3 ) = 'ab' ].

	self assert: [ ( 'abcd' slice: 2 ) = 'cd' ].
	self assert: [ ( 'abcd' slice: 1 to: 3 ) = 'bc' ].
	self assert: [ ( ( 'This is it' split: ' ' ) at: 1 ) = 'is' ].

	self assert: [ ( 'abc' padEnd: 5 ) = 'abc  ' ].
	self assert: [ ( 'def' padEnd: 6 with: 'x' ) = 'defxxx' ].

	self assert: [ ( 'abc' padStart: 5 ) = '  abc' ].
	self assert: [ ( 'def' padStart: 6 with: 'x' ) = 'xxxdef' ].

	self assert: [ ( 'ab' repeat: 3 ) = 'ababab' ].

	self assert: [ ( 'abab' replace: 'b' with: 'd' ) = 'adab' ].
	self assert: [ ( 'abab' replaceAll: 'b' with: 'd' ) = 'adad' ].

	self assert: [ '  abc  ' trim = 'abc' ].
	self assert: [ '  abc' trimStart = 'abc' ].
	self assert: [ 'abc  ' trimEnd = 'abc' ].
!
testCase
	self assert: [ 'abc' toUpperCase = 'ABC' ].
	self assert: [ 'abc' toLocaleUpperCase = 'ABC' ].

	self assert: [ 'ABC' toLowerCase = 'abc' ].
	self assert: [ 'ABC' toLocaleLowerCase = 'abc' ].
!
testEscapedChars
	| string |

	string := '\b\f\n\r\t\v'.
	self assert: [ string length = 6 ].
	self assert: [ ( string at: 0 ) = 8 ].
	self assert: [ ( string at: 1 ) = 12 ].
	self assert: [ ( string at: 2 ) = 10 ].
	self assert: [ ( string at: 3 ) = 13 ].
	self assert: [ ( string at: 4 ) = 9 ].
	self assert: [ ( string at: 5 ) = 11 ].

	string := '\\'.
	self assert: [ string length = 1 & ( ( string at: 0 ) = 92 ) ].

	string := '"'.
	self assert: [ string length = 1 & ( ( string at: 0 ) = 34 ) ].

	string := '\''.
	self assert: [ string length = 1 & ( ( string at: 0 ) = 39 ) ].

	self assert: [ 'Hello world!' isWellFormed ].
	self assert: [ 'Hello world \uD800' isWellFormed not ].
	self assert: [ 'Hello world!' toWellFormed = 'Hello world!' ].
	self assert: [ 'Hello world \uD800' toWellFormed isWellFormed ].
!
