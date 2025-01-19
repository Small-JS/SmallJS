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

	| sqlObject columnName value targetValueClass |

	sqlObject := self new.
	sqlObject id: ( row atProperty: 'id' ).
	self columns do: [ :column |
		columnName := column first.
		value := row atProperty: columnName.
		targetValueClass := column last.
		"Integer to Boolean conversion for SQLite."
		( value class = Integer ) & ( targetValueClass = Boolean ) ifTrue: [
			value := value = 1 ].
		"String to Date conversion for SQLite, Postgres."
		( value class = String ) & ( targetValueClass = Date ) ifTrue: [
			value := Date fromString: value ].    "String to Date"
		sqlObject atProperty: columnName put: value ].

	^ sqlObject.
!

"Columns"

columns
	self error: 'Overload this method to return an array of column names and types.'.
	"E.g.: ^ #( #( 'name' String ) #( 'amount' Integer ) )"
!

METHODS

"Accessing"

id
	^ id.
!
id: aId
	id := aId.
!

"Columns"

columnValues
	"Return array with values of columns variables, excluding the id column."

	^ self class columns map: [ :column |
		self atProperty: column first ].
!
