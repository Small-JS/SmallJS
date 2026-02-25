CLASS TestPlayground EXTENDS Test MODULE TestPlaygroundApp CLASSVARS '' VARS ''

test
	| playground |

	playground := Playground new.

	playground evaluate: '1 + 2'
		onResult: [ :result | self onResult: result ]
		onError: [ :error | error throw ].

!
onResult: result
	self assert: [ result = 3 ].
!
