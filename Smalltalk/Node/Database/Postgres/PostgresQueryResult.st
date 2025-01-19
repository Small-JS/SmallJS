CLASS PostgresQueryResult EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''

"This class implements a Postgres SqlQueryResult."

fieldNames
	^ Array fromJsStrings: INLINE 'this.js.fields.map( field => field.name )'.
!
rows
	^ Object fromJs: INLINE 'this.js.rows'.
!
toId
	"Return then id column value (integer) of the single row in self.
	 Otherwise return nil."

	| id rows |

	rows := self rows.
	rows length = 1 ifFalse: [ ^ nil ].
	id := rows first atProperty: 'id'.
	id class == Integer ifFalse: [ ^ nil ].
	id > 0 ifFalse: [ ^ nil ].

	^ id.
!
