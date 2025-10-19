CLASS TestDbPerson EXTENDS Test MODULE TestShopServer CLASSVARS '' VARS ''

test
	| dbPerson |
	dbPerson := DbPerson new.

	self assert: [ DbPerson columns last = #( 'salt' Integer ) ].

	dbPerson setPassword: 'secret'
		then: [ self onSetPassword: dbPerson ]
		error: [ :error | error throw ].
!
onSetPassword: dbPerson
	self assert:[ dbPerson salt >= 0 ].
	self assert:[ dbPerson password length = 64 ].
	dbPerson checkPassword: 'secret'
		then: [ :match | self onCheckPassword: match ]
		error: [ :error | error throw ].
!
onCheckPassword: match
	self assert: [ match ].
!
