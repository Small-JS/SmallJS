CLASS TestCompiler EXTENDS Test MODULE TestCore CLASSVARS ''
	VARS 'v1
	v2'

	"This class tests some compiler parsing features"

test
	self assert: [ v1 = v2 ].
!
