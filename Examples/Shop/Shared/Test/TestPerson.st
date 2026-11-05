CLASS TestPerson EXTENDS Test MODULE TestShopShared CLASSVARS '' VARS ''

test
	| person |
	person := Person new.

	self assert: [ Person columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert:[ person name = 'Test' ].

	person password: 'secret'.
	self assert:[ person password = 'secret' ].

	self assert:[ person toQuery = '?name=Test&password=secret' ].
	person name: 'A&B'; password: 'p=1 #+'.
	self assert:[ person toQuery = '?name=A%26B&password=p%3D1%20%23%2B' ].
!
