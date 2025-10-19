CLASS TestMyPerson EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS ''

test
	| person |
	person := MyPerson new.

	self assert: [ MyPerson columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert: [ person name = 'Test' ].

	person setPassword: 'secret'
		then: [ self onSetPassword: person ]
		error: [ :error | error throw ].
!
onSetPassword: person
	self assert: [ person salt >= 0 ].
	self assert: [ person password length = 64 ].
	person checkPassword: 'secret'
		then: [ :match | self onCheckPassword: match ]
		error: [ :error | error throw ].
!
onCheckPassword: match
	self assert: [ match ].
!
