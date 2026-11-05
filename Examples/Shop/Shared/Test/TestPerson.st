CLASS TestPerson EXTENDS Test MODULE TestShopShared CLASSVARS '' VARS ''

test
	| person login |
	person := Person new.

	self assert: [ Person columns first = #( 'name' String ) ].

	person name: 'Test'.
	self assert:[ person name = 'Test' ].

	person password: 'secret'.
	self assert:[ person password = 'secret' ].

	self assert:[ person toLoginJson = '{"name":"Test","password":"secret"}' ].
	"Special characters survive the JSON round trip."
	person name: 'A"B'; password: 'p=1 #+'.
	login := Person fromObject: ( Object fromJson: person toLoginJson ).
	self assert:[ login name = 'A"B' ].
	self assert:[ login password = 'p=1 #+' ].
	self assert:[ login id isNil ].
!
