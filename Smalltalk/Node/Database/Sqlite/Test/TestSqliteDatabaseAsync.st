CLASS TestSqliteDatabaseAsync EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS 'database personTable productTable orderTable'

"Tests SQL with async interface, that is compatible with that of other supported databases.
 Execution in SQLite is in fact sync, but that should not matter. "

METHODS

disabled
	"Disable these tests if database env var is not set."
	^ ( Process envAt: 'SMALLJS_SQLITE' ) isNil.
!
test
	self connect.
!
connect
	| connectionString |

	connectionString := Process envAt: 'SMALLJS_SQLITE'.
	self assert: [ connectionString includes: '.db' ].
	database := SqliteDatabase new.
	database connect: connectionString
		then: [ self onConnect ]
		catch: [ :error | error throw ].
!
onConnect
	self assert: [ true ].	"Method reached."

	personTable := database connectTable: 'Person' rowClass: MyPerson.
	productTable := database connectTable: 'Product' rowClass: MyProduct.
	orderTable := database connectTable: 'Order' rowClass: MyOrder.

	self databaseQuery.
!
databaseQuery
	database query: 'SELECT "id", "name" FROM "Person" WHERE "id" = 1'
		then: [ :rows | self onDatabaseQuery: rows ]
		catch: [ :error | error throw ].
!
onDatabaseQuery: rows
	self assert: [  rows length = 1 ].
	self assert: [ ( rows first atProperty: 'name' ) = 'John' ].

	self databaseQueryParameters.
!
databaseQueryParameters
	database query: 'SELECT "id", "name" FROM "Person" WHERE "id" = ?'
		with: #( 2 )
		then: [ :rows | self onDatabaseQueryParameters: rows ]
		catch: [ :error | error throw ].
!
onDatabaseQueryParameters: rows
	self assert: [ rows length = 1 ].
	self assert: [ ( rows first atProperty: 'name' ) = 'Michael' ].

	self tableQueryAll.
!
tableQueryAll
	productTable queryAllThen: [ :products | self onTableQueryAll: products ]
	catch: [ :error | error throw ].
!
onTableQueryAll: products
	self assert: [ products length = 3 ].

	self tableQuery.
!
tableQuery
	orderTable query: '"person" = 1'
		then: [ :orders | self onTableQuery: orders ]
		catch: [ :error | error throw ].
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
	personTable query: '"name" = ?' with: #( 'Robert' )
		then: [ :persons | self onTableQueryParameters: persons ]
		catch: [ :error | error throw ].
!
onTableQueryParameters: persons
	| person |
	self assert: [ persons length = 1 ].

	person := persons first.
	self assert: [ person id = 3 ].

	self tableQueryId.
!
tableQueryId
	productTable queryId: 2
		then: [ :product | self onTableQueryId: product ]
		catch: [ :error | error throw ].
!
onTableQueryId: product
	self assert: [ product notNil ].
	self assert: [ product id = 2 ].
	self assert: [ product name = 'Orange' ].

	self tableQueryMissingId.
!
tableQueryMissingId
	productTable queryId: -1
		then: [ :product | self onTableQueryMissingId: product ]
		catch: [ :error | error throw ].
!
onTableQueryMissingId: product
	self assert: [ product isNil ].

	self tableDeleteTest.
!
tableDeleteTest
	"Delete persons named Test*, that might have been left after an interrupted test."
	database query: 'DELETE FROM "Person" WHERE "name" LIKE \'Test%\''
		then: [ self tableInsert ]
		catch: [ :error | error throw ].
!
tableInsert
	| person |

	person := MyPerson new name: 'Test'; setPassword: 'secret'.
	personTable insert: person
		then: [ :person | self onTableInsert: person ]
		catch: [ :error | error throw ].
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
		catch: [ :error | error throw ].
!
onTableUpdate: person
	self assert: [ person name = 'Test updated' ].

	self tableDelete: person.
!
tableDelete: person
	personTable delete: person
		then: [ self onTableDelete: person ]
		catch: [ :error | error throw ].
!
onTableDelete: person
	self assert: [ person name = 'Test updated' ].

	self end.
!
end
	database end.
!
