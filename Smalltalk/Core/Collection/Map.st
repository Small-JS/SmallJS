CLASS Map EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS Map class, that is stored in the inherited 'js' variable.
	 As in a JS Map, the keys must be strings.
	 Otherwise use class Dictionary."


CLASSMETHODS

"Creating"

new
	^ self fromJs: INLINE 'new Map()'.
!
fromArray: array
	"Create map from array of arrays,
	where the inner arrays have two elements: key and value."

	| map |
	map := self new.

	array do: [ :keyValueArray |
		( keyValueArray class = Array and: [
			keyValueArray length = 2 ] ) ifFalse: [
				Error throw: 'Inner elements must be arrays of size 2' ].
		( keyValueArray at: 0 ) class = String ifFalse: [
						Error throw: 'Keys must be strings' ].
		map set: ( keyValueArray at: 0 ) value: ( keyValueArray at: 1 ) ].

	^ map.
!

"Grouping"

group: array by: block
	| map |
	map := self fromJs: INLINE 'Map.groupBy( array.js,
		( element ) => block.js( element ).js )'.
	"Now convert all values from JS array to ST array."
	map forEach: [ :key :jsArray |
		map set: key value: ( Array fromJs: jsArray ) ].
	^ map.
!

METHODS

"Converting"

toString
	| result |
	result := 'Map( '.
	self forEach: [ :key :value |
		result := result, ( KeyValue key: key value: value ) toString, ' ' ].
	result := result, ')'.
	^ result.
!
toArray
	"Convert self to array of arrays,
	where the inner arrays have two elements: key and value."

	^ self entries.
!

"Properties"

size
	^ Integer fromJs: INLINE 'this.js.size'.
!

"Getting"

get: key
	^ Nil fromJs: INLINE 'this.js.get( key.js )'.
!

"Setting"

set: key value: value
	INLINE 'this.js.set( key.js, value )'.
!

"Deleting"

delete: key
	^ Boolean fromJs: INLINE 'this.js.delete( key.js )'.
!
clear
	INLINE 'this.js.clear()'.
!

"Testing"

has: key
	^ Boolean fromJs: INLINE 'this.js.has( key.js )'.
!

"Iterating"

keys
	^ Array fromJs: INLINE 'Array.from( this.js.keys() )' elementClass: String.
!
values
	^ Array fromJs: INLINE 'Array.from( this.js.values() )'.
!
entries
	^ Array fromJs: INLINE 'Array.from( this.js.entries() )' elementConverter:
		[ :jsEntry | Array with: INLINE 'stString$class.$fromJs$( jsEntry[ 0 ] )' with: INLINE 'jsEntry[ 1 ]' ].
!
forEach: block
	"Note: The block must have :key and :value as the 1st and 2nd argument."
	INLINE 'this.js.forEach( ( value, key ) => block.js( stString$class.$fromJs$( key ), value ) )'.
!
do: block
	"Alias for 'forEach:'"
	self forEach: block.
!
