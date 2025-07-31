CLASS FormData EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ FormData fromJs: INLINE 'new FormData()'.
!
form: form
	^ FormData fromJs: INLINE 'new FormData( form.js )'.
!
form: form submitter: button
	^ FormData fromJs: INLINE 'new FormData( form.js, button.js )'.
!

METHODS

"CRUD"

get: name
	^ self jsValueToSt: INLINE 'this.js.get( name.js )'.
!
getAll: name
	^ Array fromJs: INLINE 'this.js.getAll( name.js )'
		elementConverter: [ :js | self jsValueToSt: js ].
!
set: name value: value
	INLINE 'this.js.set( name.js, value.js )'.
!
append: name value: value
	INLINE 'this.js.append( name.js, value.js )'.
!
delete: name
	INLINE 'this.js.delete( name.js )'.
!

"Iterating"

keys
	^ Array fromJsStrings: INLINE 'Array.from( this.js.keys() )'.
!
values
	^ Array fromJs: INLINE 'Array.from( this.js.values() )'
		elementConverter: [ :js | self jsValueToSt: js ].
!
entries
	^ Array fromJs: INLINE 'this.js.entries()' elementConverter: [ :jsArray |
		Array fromJs: jsArray elementConverter: [ :js |
			self jsValueToSt: js ] ].
!

"Testing "

has: name
	^ Boolean fromJs: INLINE 'this.js.has( name.js )'.
!

"Private - helper"

jsValueToSt: js
	"Encapsulate the argument to the correct ST class, File or String.
	 Note: Blob objects put into FormData are stored as File objects."
	| jsObject |
	jsObject := JsObject fromJs: js.
	^ jsObject jsClassName = 'File'
		ifTrue: [ File fromJs: js ]
		ifFalse: [ String fromJs: js ]
!
