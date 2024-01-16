CLASS Headers EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Headers()'.
!
init: strings
	^ self fromJs: strings toJs.
!

METHODS

"CRUD"

append: name value: value
	INLINE 'this.js.append( name.js, value.js )'.
!
get: name
	^ String fromJs: INLINE 'this.js.get( name.js )'.
!
set: name value: value
	INLINE 'this.js.append( name.js, value.js )'.
!
delete: name
	INLINE 'this.js.delete( name.js )'.
!

"Testing "

has: name
	^ Boolean fromJs: INLINE 'this.js.has( name.js )'.
!

"Iterating"

entries
	^ Array fromJs: INLINE 'this.js.entries()' elementConverter: [ :jsArray |
		Array fromJs: jsArray elementClass: String ].
!
keys
	^ Array fromJs: INLINE 'this.js.keys()' elementClass: String.
!
values
	^ Array fromJs: INLINE 'this.js.values()' elementClass: String.
!

"Cookie"

getSetCookie
	^ Array fromJs: INLINE 'this.js.getSetCookie()' elementClass: String.
!
