CLASS KeyValue EXTENDS Object MODULE Core CLASSVARS '' VARS 'key value'

"Simple holder for a key and value pair.
Used in class Dictionary."

CLASSMETHODS

"Creating"

key: key value: value
	^ self new key: key; value: value.
!

METHODS

"Accessing"

key
	^ key.
!
key: aKey
	key := aKey.
!
value
	^ value.
!
value: aValue
	value := aValue.
!

"Converting"

toString
	^ '{ ', key toString, ', ', value toString, ' }'.
!
