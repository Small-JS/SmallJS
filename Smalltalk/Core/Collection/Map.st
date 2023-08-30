CLASS Map EXTENDS Collection MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS Map class, that is stored in the inherited 'js' variable.
	 As in a JS Map, the keys must be strings."

METHODS

constructor
	js := INLINE 'new Map()'.
!
size
	^ Integer fromJs: INLINE 'this.js.size'.
!
clear
	INLINE 'this.js.clear()'.
!
delete: key
	^ Boolean fromJs: INLINE 'this.js.delete( key.js )'.
!
get: key
	^ INLINE 'this.js.get( key.js )'.
!
has: key
	^ Boolean fromJs: INLINE 'this.js.has( key.js )'.
!
set: key value: value
	INLINE 'this.js.set( key.js, value )'.
!
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
	INLINE 'this.js.forEach( ( value, key ) => block.js( key, value ) )'.
!

