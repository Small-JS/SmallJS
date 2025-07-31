CLASS Headers EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Headers()'.
!
init: entries
	^ self fromJs: INLINE 'new Headers( entries.$toJs() )'.
!

METHODS

"Modifying"

append: name value: value
	INLINE 'this.js.append( name.js, value.js )'.
!
get: name
	^ String fromJs: INLINE 'this.js.get( name.js )'.
!
set: name value: value
	"Note: This method *appends* values to any exiting values, comma separated."
	INLINE 'this.js.append( name.js, value.js )'.
!
delete: name
	INLINE 'this.js.delete( name.js )'.
!

"Testing"

has: name
	^ Boolean fromJs: INLINE 'this.js.has( name.js )'.
!

"Iterating"

entries
	| pairsJs |
	pairsJs := Array fromJs: INLINE 'Array.from( this.js.entries() )'.
	^ pairsJs map: [ :jsPair | Array fromJsStrings: jsPair ].
!
keys
	^ Array fromJsStrings: INLINE 'Array.from( this.js.keys() )'.
!
values
	^ Array fromJsStrings: INLINE 'Array.from( this.js.values() )'.
!

"Cookie"

getSetCookie
	"This returns an *array* of cookie values."
	^ Array fromJsStrings: INLINE 'this.js.getSetCookie()'.
!
