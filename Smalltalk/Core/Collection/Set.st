CLASS Set EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

"Note: This ST implementation of Set is much slower than the encapsulated JS set,
 because testing for equality of set values (basic types) must always be done through ST,
 iterating over the whole set for every item tested."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Set()'.
!
new: array
	^ self fromJs: INLINE 'new Set( array.js )'.
!

METHODS

"Accessing"

size
	^ Integer fromJs: INLINE 'this.js.size'.
!
forEach: block
	INLINE 'this.js.forEach( block.js )'.
!

"Converting"

values
	^ Array fromJs: INLINE 'Array.from( this.js.values() )'.
!
keys
	^ self values.
!
entries
	| result |
	result := Array new.
	self forEach: [ :value |
		result add: #( value value ) ].
	^ result.
!
toString
	| string |
	string := 'Set('.
	self forEach: [ :value |
		string := string, ' ', value toString ].
	string := string, ' )'.
	^ string.
!

"Modifying"

add: value
	( self find: value ) ifNil: [
		INLINE 'this.js.add( value )' ].
!
clear
	INLINE 'this.js.clear()'.
!
delete: value
	| ownValue |
	ownValue := self find: value.
	ownValue ifNotNil: [
		INLINE 'this.js.delete( ownValue )' ].
!

"Operations with other sets"

difference: set
	| result |
	result := Set new.
	self forEach: [ :value |
		( set has: value ) ifFalse: [
			result add: value ] ].
	^ result.
!
intersection: set
	| result |
	result := Set new.
	self forEach: [ :value |
		( set has: value ) ifTrue: [
			result add: value ] ].
	^ result.
!
symmetricDifference: set
	| result |
	result := Set new.

	self forEach: [ :value |
		( set has: value ) ifFalse: [
			result add: value ] ].

	set forEach: [ :value |
		( self has: value ) ifFalse: [
			result add: value ] ].

	^ result.
!
union: set
	| result |
	result := Set new.

	self forEach: [ :value |
		( result has: value ) ifFalse: [
			result add: value ] ].

	set forEach: [ :value |
		( result has: value ) ifFalse: [
			result add: value ] ].

	^ result.
!

"Testing"

find: aValue
	"Return the object in the set that is (value)equal to the argument value, otherwise nil"
	self forEach: [ :value |
		value = aValue ifTrue: [ ^ value ] ].
	^ nil.
!
has: value
	^ ( self find: value ) notNil.
!
isDisjointFrom: set
	self forEach: [ :value |
		( set has: value ) ifTrue: [
			^ false ] ].
	^ true.
!
isSubsetOf: set
	self forEach: [ :value |
		( set has: value ) ifFalse: [
			^ false ] ].
	^ true.
!
isSupersetOf: set
	^ set isSubsetOf: self.
!
