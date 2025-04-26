CLASS TestDbPerson EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

test
	| dbPerson |
	dbPerson := DbPerson new.

	self assert: [ DbPerson columns last = #( 'salt' Integer ) ].

	dbPerson setPassword: 'secret'.
	self assert:[ dbPerson checkPassword: 'secret' ].
	self assert:[ dbPerson salt >= 0 ].
	self assert:[ dbPerson password length = 64 ].
!
