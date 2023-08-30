CLASS PostgresQueryResult EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''
	"This class implements a Postgres SqlQueryResult."

METHODS

fieldNames
	^ Array fromJsStrings: INLINE 'this.js.fields.map( field => field.name )'.
!
rows
	^ Object fromJs: INLINE 'this.js.rows'.
!
toId
	"Return then id column value (integer) of the single row in self.
	 Otherwise throw an error (malformed query result)."

	| id |

	self rows length = 1 ifFalse: [
		self error: 'Not exactly 1 id row returned' ].

	id := self rows first atProperty: 'id'.
	id notNil ifFalse: [
		self error: 'JS property "id" not found.' ].

	id class == Integer ifFalse: [
		self error: 'Returned id is not an integer.' ].

	id > 0 ifFalse: [
		self error: 'Invalid id value: ', id toString ].

	^ id.
!
checkId: aId
	"Return true if self contains the argument id.
	 Otherwise throw an error."

	| id |

	id := self toId.
	id ~= aId ifTrue: [
		self error: 'Returned id: ', id toString, ' does not match expected id: ', aId toString ].
!
