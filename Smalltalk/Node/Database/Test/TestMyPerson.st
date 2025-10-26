CLASS TestMyPerson EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS ''

async test
	| person |
	person := MyPerson new.

	self assert: [ MyPerson columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert: [ person name = 'Test' ].

	await person setPassword: 'secret'.
	self assert: [ person salt >= 0 ].
	self assert: [ person password length = 64 ].

	await self assertAsync: [ person checkPassword: 'secret' ].
!
