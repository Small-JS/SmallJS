CLASS TestError EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| error cause |

	self assertError: [ Error throw: 'My error' ].
	[ Error throw: 'My error' ] tryCatch: [ :error | self onError: error ].

	error := Error new.
	self assert: [ error message = '' ].
	error message: 'My message'.
	self assert: [ error message = 'My message' ].

	error := Error new: 'New error'.
	self assert: [ error message = 'New error' ].
	self assertError: [ error throw ].

	self assert: [ error cause isNil ].
	cause := Error new: 'Error cause'.
	error cause: cause.
	self assert: [ error cause message = 'Error cause' ].

	error := Error new: 'Error with cause' cause: cause.
	self assert: [ error cause message = 'Error cause' ].
!
onError: error
	self assert: [ error message = 'My error' ].
	self assert: [ error name = 'Error' ].
	self assert: [ error toString = 'Error: Error: My error' ].
!
