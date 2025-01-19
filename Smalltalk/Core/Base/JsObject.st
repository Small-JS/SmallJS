CLASS JsObject EXTENDS Object MODULE Core CLASSVARS '' VARS 'js'
	"This abstract class implements and association of a ST object to a JS object.
	 The variable 'js' contains the JS object associated with the ST object."

CLASSMETHODS

"Creating"

newEmpty
	^ self fromJs: INLINE '{}'.
!
fromJs: aJs
	INLINE 'if( aJs == null ) return stNil'.
	^ self basicNew js: aJs.
!

METHODS

"Comparing"

= object
	"JsObjects instances are considered equal if their encapsulated JS objects are equal."
	^ Boolean fromJs: INLINE 'this.js === object.js'
!

"Accessing"

js
	"Note: This returns a JS object, not a ST object."
	^ js.
!
js: aJs
	"Note: aJs should be a JS object, not a ST object."
	js := aJs.
!
jsClassName
	^ self isUndefined
		ifTrue: [ 'undefined' ]
		ifFalse: [ String fromJs: INLINE 'this.js.constructor.name' ].
!
jsType
	^ String fromJs: INLINE 'typeof this.js'
!
ownJsPropertyNames
	^ Array fromJs: INLINE 'Object.getOwnPropertyNames( this.js )' elementClass: String.
!
atJsProperty: name
	"Returns ST object for JS property value in current object.
	 An instance of: String, Number subclass, Boolean, Nil."

	^ Object fromJs: INLINE 'this.js[ name.js ]'.
!
atJsProperty: name put: value
	"Put the .js of argument in self."

	INLINE 'this.js[ name.js ] = value.$toJs()'.
!

"Testing"

isNull
	"Also returns true if this.js is 'undefined'."
	^ Boolean fromJs: INLINE 'this.js == null'.
!
isUndefined
	"Also returns true if this.js is 'null'."
	^ self isNull.
!
isArray
	^ Boolean fromJs: INLINE 'Array.isArray( this.js )'.
!
isObject
	^ Boolean fromJs: INLINE 'typeof this.js == "object"'.
!
isEmpty
	^ Boolean fromJs: INLINE 'Object.keys( this.js ).length === 0'.
!

"Converting"

toJs
	"Returns js representation of self.
	 Array overloads this to convert array elements to JS also, recursively."

	^ js.
!
toString
	| jsType |
	jsType := self isUndefined
		ifTrue: [ 'undefined' ]
		ifFalse: [ String fromJs: INLINE 'this.js.toString()' ]
	^ 'a ', self class name, '( ', jsType, ' )'.
!
