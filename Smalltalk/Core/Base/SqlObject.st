CLASS SqlObject EXTENDS Object MODULE Core CLASSVARS '' VARS 'id'
	"This class implements an abstract SQL Object.
	 It is used for leightweight ORM and CRUD operations.
	 The variable 'id' contains  the unique integer that must also be a serial (autonumber) column in the associated SQL table.
	 This base class is designed to be independent of other database classes,
	 so it can be used in the front-end (browser) as well as in the back-end (Node.JS).
 	 Note: Using this base class for SQL database access is optional."

CLASSMETHODS

"Creation"

fromRows: rows
	"Return array of instances of self (subclass) with data from Object class rows."

	| sqlObjects |

	sqlObjects := Array new.

	rows do: [ :row |
		sqlObjects add: ( self fromRow: row ) ].

	^ sqlObjects.
!
fromRow: row
	"Return instance of self (subclass) with data from row."

	| sqlObject |

	sqlObject := self new.
	sqlObject id: ( row atProperty: 'id' ).
	self columns do: [ :column |
		sqlObject atProperty: column put: ( row atProperty: column ) ].

	^ sqlObject.
!

"Columns"

columns
	self error: 'Overload this method to return an array of column names (strings) that are also equal to instvars names to store.'.
!

METHODS

id
	^ id.
!
id: aId
	id := aId.
!
columnValues
	"Return array with values of columns variables, excluding the id column."

	| result |

	result := Array new.
	self class columns do: [ :column |
		result add: ( self atProperty: column )  ].
	^ result.
!
