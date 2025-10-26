CLASS TestDbPerson EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

async test
	| dbPerson match |
	dbPerson := DbPerson new.

	self assert: [ DbPerson columns last = #( 'salt' Integer ) ].

	await dbPerson setPassword: 'secret'.
	self assert:[ dbPerson salt >= 0 ].
	self assert:[ dbPerson password length = 64 ].

	match := await dbPerson checkPassword: 'secret'.
	self assert: [ match ].
!
