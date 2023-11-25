CLASS TestError EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| error |

	self assertError: [ Error throw: 'My error' ].
	[ Error throw: 'My error' ] valueOnError: [ :error | self onError: error ].

	error := Error new.
	self assert: [ error message = '' ].
	error message: 'My message'.
	self assert: [ error message = 'My message' ].

	error := Error new: 'New error'.
	self assert: [ error message = 'New error' ].
	self assertError: [ error throw ].
!
onError: error
	self assert: [ error message = 'My error' ].
	self assert: [ error name = 'Error' ].
	self assert: [ error toString = 'Error: Error: My error' ].
!
