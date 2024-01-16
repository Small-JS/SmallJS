CLASS TestMariadbDatabase EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS 'database personTable productTable orderTable'

CLASSMETHODS

METHODS

enabled
	"Disable these tests if database env var is not set."
	^ ( Process envAt: 'SMALLJS_MARIADB' ) notNil.
!
test
	| connectionString |

	connectionString := Process envAt: 'SMALLJS_MARIADB'.
	self assert: [ connectionString includes: 'mariadb' ].

	database := MariadbDatabase new.
	database connect: connectionString then: [ self onConnect ].
!
onConnect
	self assert: [ database threadId >= 0 ] .
	self assert: [ database status >= 0 ] .

	personTable := database connectTable: 'Person' rowClass: MyPerson.
	productTable := database connectTable: 'Product' rowClass: MyProduct.
	orderTable := database connectTable: 'Order' rowClass: MyOrder.

	self databaseQuery.
!
databaseQuery
	database query: 'SELECT `id`, `name` FROM `Person` WHERE `id` = 1'
		then: [ :rows | self onDatabaseQuery: rows ].
!
onDatabaseQuery: rows
	self assert: [ rows length = 1 ].
	self assert: [ ( rows first atProperty: 'name' ) = 'John' ].

	self databaseQueryParameters.
!
databaseQueryParameters
	database query: 'SELECT `id`, `name` FROM `Person` WHERE `id` = ?' with: #( 2 )
		then: [ :rows | self onDatabaseQueryParameters: rows ].
!
onDatabaseQueryParameters: rows
	self assert: [ rows length = 1 ].
	self assert: [ ( rows first atProperty: 'name' ) = 'Michael' ].

	self tableQueryAll.
!
tableQueryAll
	productTable queryAllThen: [ :products | self onTableQueryAll: products ].
!
onTableQueryAll: products
	self assert: [ products length = 3 ].

	self tableQuery.
!
tableQuery
	orderTable query: '`person` = 1'
		then: [ :orders | self onTableQuery: orders ].
!
onTableQuery: orders
	| order |

	self assert: [ orders length = 2 ].

	order := orders first.
	self assert: [ order id = 1 ].
	self assert: [ order person = 1 ].
	self assert: [ order product = 1 ].
	self assert: [ order amount = 10 ].

	order := orders last.
	self assert: [ order id = 2 ].
	self assert: [ order person = 1 ].
	self assert: [ order product = 2 ].
	self assert: [ order amount = 5 ].

	self tableQueryParameters.
!
tableQueryParameters
	personTable query: '`name` = ?' with: #( 'Robert' )
		then: [ :persons | self onTableQueryParameters: persons ].
!
onTableQueryParameters: persons
	| person |
	self assert: [ persons length = 1 ].

	person := persons first.
	self assert: [ person id = 3 ].

	self tableQueryId.
!
tableQueryId
	productTable queryId: 2 then:
		[ :product | self tableQueryId: product ].
!
tableQueryId: product
	self assert: [ product id = 2 ].
	self assert: [ product name = 'Orange' ].

	self deleteMyPerson.
!
deleteMyPerson
	"Delete person named 'Test' in case it was left behind by by a previous error after inserting."
	database query: 'DELETE FROM Person WHERE `name` = "Test"'
	then: [ self tableInsert ].
!
tableInsert
	| person |

	person := MyPerson new name: 'Test'; setPassword: 'secret'.
	self assert: [ person salt >= 0 ].
	self assert: [ person password length = 64 ].
	self assert: [ person checkPassword: 'secret' ].

	personTable insert: person
		then: [ :person | self onTableInsert: person ].
!
onTableInsert: person
	self assert: [ person id > 0 ].
	self assert: [ person name = 'Test' ].

	self tableUpdate: person.
!
tableUpdate: person
	person name: 'Test updated'.
	personTable update: person
		then: [ self onTableUpdate: person ]
!
onTableUpdate: person
	self assert: [ person name = 'Test updated' ].

	self tableDelete: person.
!
tableDelete: person
	personTable delete: person
		then: [ self onTableDelete: person ]
!
onTableDelete: person
	self assert: [ person name = 'Test updated' ].

	self end.
!
end
	database end.
!
