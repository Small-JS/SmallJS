CLASS TestCompiler EXTENDS Test MODULE TestCore CLASSVARS 'c1'
	VARS 'v1
	v2'

	"This class tests some compiler parsing features"

CLASSMETHODS

testClass
	self assert: [ c1 isNil ].
!

METHODS

test
	self assert: [ c1 = v1 ].
	self assert: [ v1 = v2 ].
	self assert: [ 1+2=3 ].
	self assert: [ self A: 1 b: 2 ].
!
A:a b:b
	^ true.
!
