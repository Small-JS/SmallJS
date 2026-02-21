CLASS TestCharacter EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testCreation
	self assert: [ ( Character fromCode: 65 ) = $A ].
	self assert: [ Character newline code = 10 ].
!
testAcesssing
	self assert: [ $A code = 65 ].
!
testConverting
	self assert: [ $a toString = 'a' ].

	self assert: [ $a toUpperCase = $A ].
	self assert: [ $1 toUpperCase = $1 ].

	self assert: [ $B toLowerCase = $b ].
	self assert: [ $@ toUpperCase = $@ ].
!
testComparisons
	self assert: [ $a = $a ].
	self assert: [ $a ~= $b ].
	self assert: [ $a < $b ].
	self assert: [ $a <= $a ].
!
testTesting
	self assert: [ $a isLowerCase ].
	self assert: [ $Z isUpperCase ].
	self assert: [ $e isLetter ].
	self assert: [ $. isLetter not ].
!
