CLASS TestSqliteDatabaseSync EXTENDS Test MODULE TestDatabase CLASSVARS '' VARS 'database personTable productTable orderTable'

METHODS

disabled
	"Disable these tests if database env var is not set."
	^ ( Process envAt: 'SMALLJS_SQLITE' ) isNil.
!
test
	| person |
	self open.
	self databaseQuery.
	self tableQueryAll.
	self tableQuery.
	self tableQueryParameters.
	self tableQueryId.
	person := self tableInsert.
	person := self tableUpdate: person.
	self tableDelete: person.
	self close.
!
open
	| path |
	path := Process envAt: 'SMALLJS_SQLITE'.
	SqliteDatabase checkExists: path.
	database := SqliteDatabase new: path.
	database checkValid.

	personTable := database connectTable: 'Person' rowClass: MyPerson.
	productTable := database connectTable: 'Product' rowClass: MyProduct.
	orderTable := database connectTable: 'Order' rowClass: MyOrder.
!
databaseQuery
	| statement rows |

	statement := database prepare: 'SELECT "id", "name" FROM "Person" WHERE "id" = ?'.
	rows := statement all: #( 1 ).

	self assert: [ rows length = 1 ].
	self assert: [ ( rows first atProperty: 'id' ) = 1 ].
	self assert: [ ( rows first atProperty: 'name' ) = 'John' ].
!
tableQueryAll
	| products |
	products := productTable queryAll.

	self assert: [ products length = 3 ].
	self assert: [ ( products first atProperty: 'id' ) = 1 ].
	self assert: [ ( products first atProperty: 'name' ) = 'Apple' ].
!
tableQuery
	| order orders |

	orders := orderTable query: '"Person" = 1'.
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
!
tableQueryParameters
	| persons person |

	persons := personTable query: '"name" = ?' with: #( 'Robert' ).
	self assert: [ persons length = 1 ].

	person := persons first.
	self assert: [ person id = 3 ].
!
tableQueryId
	| product |

	product := productTable queryId: 2.
	self assert: [ product id = 2 ].
	self assert: [ product name = 'Orange' ].
!
tableDeleteTest
	"Delete person named Test*, that might have been left after an interrupted test."
	database exec: 'DELETE FROM "Person" WHERE "name" LIKE \'Test%\''
!
tableInsert
	| person |

	self tableDeleteTest.

	person := MyPerson new name: 'Test'; setPassword: 'secret'.
	personTable insert: person.
	self assert: [ person id > 0 ].

	^ person.
!
tableUpdate: person
	| updatedPerson |
	person name: 'Test updated'.
	personTable update: person.

	updatedPerson := personTable queryId: person id.
	self assert: [ updatedPerson name = 'Test updated' ].

	^ person.
!
tableDelete: person
	personTable delete: person.
	self assert: [ ( personTable queryId: person id ) isNil ].
!
close
	database close.
!
