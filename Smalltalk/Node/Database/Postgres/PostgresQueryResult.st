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
	 Otherwise return nil."

	| id |

	self rows length = 1 ifFalse: [ ^ nil ].
	id := self rows first atProperty: 'id'.
	id class == Integer ifFalse: [ ^ nil ].
	id > 0 ifFalse: [ ^ nil ].

	^ id.
!
