CLASS FormData EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''

CLASSMETHODS

form: form
	^ FormData fromJs: INLINE 'new FormData( form.js )'.
!
form: form submitter: button
	^ FormData fromJs: INLINE 'new FormData( form.js, button.js )'.
!

METHODS

"CRUD"

get: name
	^ String fromJs: INLINE 'this.js.get( name.js )'.
!
getAll: name
	^ Array fromJs: INLINE 'this.js.get( name.js )' elemenClass: String.
!
set: name value: value
	INLINE 'this.js.append( name.js, value.js )'.
!
append: name value: value
	INLINE 'this.js.append( name.js, value.js )'.
!
delete: name
	INLINE 'this.js.delete( name.js )'.
!

"Iterating"

entries
	^ Array fromJs: INLINE 'this.js.entries()'.
!
keys
	^ Array fromJs: INLINE 'this.js.keys()'.
!
values
	^ Array fromJs: INLINE 'this.js.values()'.
!

"Testing "

has: name
	^ Boolean fromJs: INLINE 'this.js.has( name.js )'.
!
