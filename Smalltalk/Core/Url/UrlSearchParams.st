CLASS UrlSearchParams EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class: URLSearchParams.
	 It works in browsers and in Node.js.
	 Names and values are Strings. A name can occur multiple times."

CLASSMETHODS

"Creating"

new
	^ self fromJs: INLINE 'new URLSearchParams()'.
!
init: init
	"The argument can be a query String (with or without leading '?'),
	 an Array of name-value pairs, or a JsObject with String properties."
	^ self fromJs: INLINE 'new URLSearchParams( init.$toJs() )'.
!

METHODS

"Accessing"

size
	"The total number of name-value pairs."
	^ Integer fromJs: INLINE 'this.js.size'.
!
get: name
	"Return the first value for name, or nil if name does not exist."
	^ String fromJs: INLINE 'this.js.get( name.js )'.
!
getAll: name
	^ Array fromJsStrings: INLINE 'this.js.getAll( name.js )'.
!

"Modifying"

append: name value: value
	INLINE 'this.js.append( name.js, value.$toJs() )'.
!
set: name value: value
	"Replace any existing values of name. Use append:value: to add a value."
	INLINE 'this.js.set( name.js, value.$toJs() )'.
!
delete: name
	INLINE 'this.js.delete( name.js )'.
!
delete: name value: value
	"Delete only the pairs with this name and value."
	INLINE 'this.js.delete( name.js, value.$toJs() )'.
!
sort
	"Sort the pairs by name, stable for pairs with the same name."
	INLINE 'this.js.sort()'.
!

"Testing"

has: name
	^ Boolean fromJs: INLINE 'this.js.has( name.js )'.
!
has: name value: value
	^ Boolean fromJs: INLINE 'this.js.has( name.js, value.$toJs() )'.
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

"Converting"

toString
	"Return the query String, without leading '?'."
	^ String fromJs: INLINE 'this.js.toString()'.
!
