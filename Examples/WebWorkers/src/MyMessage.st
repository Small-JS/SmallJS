CLASS MyMessage EXTENDS Object MODULE WebWorkersApp CLASSVARS ''
	VARS 'id size'

CLASSMETHODS

fromJs: jsObject
	^ self new
		id: ( jsObject atJsProperty: 'id' );
		size: ( jsObject atJsProperty: 'size' ).
!

METHODS

"Accessing"

id
	^ id.
!
id: aId
	id := aId.
!
size
	^ size.
!
size: aSize
	size := aSize.
!

"Conversion"

toString
	^ 'MyMessage( id: ', id toString, ', size: ', size toString, ' )'.
!
