CLASS TestPlayground EXTENDS Test MODULE TestPlayground CLASSVARS '' VARS ''

test
	| playground |

	playground := Playground new.

	playground evaluate: '1 + 2'
		onResult: [ :result | self onResult: result ]
		onError: [ :error | self onError: error ].

!
onResult: result
	self assert: [ result = 3 ].
!
onError: error
	error throw.
!
