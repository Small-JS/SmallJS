CLASS TestError EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assertError: [ Error throw: 'My error.' ].

	[ Error throw: 'My error.' ] valueOnError: [ :error | self onError: error ].
!
onError: error
	self assert: [ error message = 'My error.' ].
	self assert: [ error name = 'Error' ].
	self assert: [ error toString = 'Error: Error: My error.' ].
!
