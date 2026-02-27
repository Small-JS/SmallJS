CLASS Dictionary EXTENDS Object MODULE Core CLASSVARS '' VARS 'keyValues'

"Dictionary that can have arbitrary objects as keys.
Note: Simple, low performance implementation.
Use class Map when keys are strings."

CLASSMETHODS

"Creating"

fromArray: array
	"Create dictionary from array of arrays,
	where the inner arrays have two elements: key and value."

	| dictionary |
	dictionary := self new.

	array do: [ :keyValueArray |
		( keyValueArray class = Array and: [
			keyValueArray length = 2 ] ) ifFalse: [
				Error throw: 'Inner elements must be arrays of size 2' ].
		dictionary at: ( keyValueArray at: 0 ) put: ( keyValueArray at: 1 ) ].

	^ dictionary.
!

METHODS

"Initializing"

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
toArray
	"Convert self to array of arrays,
	where the inner arrays have two elements: key and value."

	| array keyValueArray |
	array := Array new.

	self do: [ :key :value  |
		keyValueArray := Array new: 2.
		keyValueArray at: 0 put: key.
		keyValueArray at: 1 put: value.
		array add: keyValueArray ].

	^ array.
!

"Properties"

size
	^ keyValues length.
!
keyValues
	^ keyValues.
!

"Testing"

has: key
	^ ( self find: key ) notNil.
!
find: key
	"Return KeyValue with key or nil if not found."
	^ keyValues find: [ :keyValue | keyValue key = key ]
!

"Accessing"

at: key
	"Return value at key, or thorw an error if the key is absent."
	^ self at: key ifAbsent: [
		Error throw: 'Key not found: ', key toString ]
!
at: key ifAbsent: block
	"Return value at key, or the results of block if the key is absent."
	| keyValue |
	keyValue := self find: key.
	keyValue notNil ifTrue: [
		^ keyValue value ].
	^ block value.
!
at: key put: value
	| keyValue |

	"If key not found, create and add a new KeyValue."
	keyValue := self find: key.
	keyValue ifNil: [
		keyValue := KeyValue new key: key.
		keyValues add: keyValue ].

	keyValue value: value.
!
do: block
	"Evaluate block with each key and value pair as argument."
	keyValues do: [ :keyValue |
		block value: keyValue key value: keyValue value ].
!

"Removing"

removeAt: key
	| index |
	index := keyValues findIndex: [ :keyValue | keyValue key = key ].
	index >= 0 ifTrue: [
		keyValues removeAt: index ].
!
clear
	keyValues := Array new.
!
