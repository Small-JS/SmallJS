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
!
testComparisons
	self assert: [ $a = $a ].
	self assert: [ $a ~= $b ].
	self assert: [ $a < $b ].
	self assert: [ $a <= $a ].
!
testTesting
	self assert: [ $a isLowercase ].
	self assert: [ $Z isUppercase ].
	self assert: [ $e isLetter ].
	self assert: [ $. isLetter not ].
!
