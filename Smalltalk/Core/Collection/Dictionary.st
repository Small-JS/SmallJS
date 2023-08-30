CLASS Dictionary EXTENDS Collection MODULE Core CLASSVARS '' VARS 'keyValues'
	"Variable keyValuePairs contains an array of arrays of 2 elements; key and value.
	 Note: Simple, low performance implementation now. Should use hashing.
	 Use class Map when keys are strings."

METHODS

constructor
	keyValues := Array new.
!
at: key ifAbsent: block
	keyValues do: [ :keyValue |
		( keyValue at: 0 ) = key ifTrue: [ ^ keyValue at: 1 ] ].
	^ block value.
!
at: key put: value
	| keyValue |
	keyValue := self at: key ifAbsent: [
		keyValue := Array new: 2.
		keyValues add: keyValue.
		keyValue at: 0 put: key ].
	keyValue at: 1 put: value.
!
removeAt: key
	| index |
	index := keyValues findIndex: [ :keyValue | ( keyValue at: 0 ) = key ].
	index >= 0 ifTrue: [ keyValues removeAt: index ].
!
do: block
	keyValues do: [ :keyValue |
		block value: ( keyValue at: 0 ) value: ( keyValue at: 1 ) ].
!
size
	^ keyValues length.
!
