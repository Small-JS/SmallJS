CLASS Dictionary EXTENDS Object MODULE Core CLASSVARS '' VARS 'keyValues'

"Dictionary that can have arbitrary objects as keys.
Note: Simple, low performance implementation.
Use class Map when keys are strings."

METHODS

"Creating"

constructor
	keyValues := Array new.
!

"Converting"

toString
	| result |
	result := 'Dictionary( '.
	keyValues do: [ :keyValue |
		result := result, keyValue toString, ' ' ].
	result := result, ')'.
	^ result.
!
at: key
	"Return value at key, or thorw an error if the key is absent."
	^ self at: key ifAbsent: [
		Error throw: 'Key not found: ', key toString ]
!
at: key ifAbsent: block
	"Return value at key, or the results of block if the key is absent."
	keyValues do: [ :keyValue |
		keyValue key = key ifTrue: [ ^ keyValue value ] ].
	^ block value.
!
at: key put: value
	| newKeyValue |

	"Check for existing key."
	keyValues do: [ :keyValue |
		keyValue key = key ifTrue: [
			keyValue value: value. ^ self ] ].

	"Otherwise add new key."
	newKeyValue := KeyValue key: key value: value.
	keyValues add: newKeyValue.
!
removeAt: key
	| index |
	index := keyValues findIndex: [ :keyValue | keyValue key = key ].
	index >= 0 ifTrue: [ keyValues removeAt: index ].
!
do: block
	"Evaluate block with each key and value pair as argument."
	keyValues do: [ :keyValue |
		block value: keyValue key value: keyValue value ].
!
size
	^ keyValues length.
!
