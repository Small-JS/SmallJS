CLASS Set EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

"Note: This ST implementation of Set is much slower than the encapsulated JS set,
 because testing for equality of set values (basic types) must always be done through ST,
 iterating over the whole set for every item tested."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Set()'.
!
new: array
	"Values are added one by one, so (value)equal duplicates in array are removed."
	| set |
	set := self new.
	array do: [ :value | set add: value ].
	^ set.
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
	( self has: value ) ifFalse: [
		INLINE 'this.js.add( value )' ].
!
addUnchecked: value
	"Private: Add value without testing for (value)equality.
	 Only use for values known not to be in self."
	INLINE 'this.js.add( value )'.
!
clear
	INLINE 'this.js.clear()'.
!
delete: aValue
	"Delete the object in the set that is (value)equal to the argument value, if any."
	self forEach: [ :value |
		value = aValue ifTrue: [
			INLINE 'this.js.delete( value )'.
			^ self ] ].
!

"Operations with other sets"

difference: set
	| result |
	result := Set new.
	self forEach: [ :value |
		( set has: value ) ifFalse: [
			result addUnchecked: value ] ].
	^ result.
!
intersection: set
	| result |
	result := Set new.
	self forEach: [ :value |
		( set has: value ) ifTrue: [
			result addUnchecked: value ] ].
	^ result.
!
symmetricDifference: set
	"Both parts are free of duplicates and disjoint, so they are added unchecked."
	| result |
	result := Set new.

	self forEach: [ :value |
		( set has: value ) ifFalse: [
			result addUnchecked: value ] ].

	set forEach: [ :value |
		( self has: value ) ifFalse: [
			result addUnchecked: value ] ].

	^ result.
!
union: set
	"self has no duplicates, so its JS set can be copied without equality tests.
	 add: already skips values that are present."
	| result |
	result := Set fromJs: INLINE 'new Set( this.js )'.
	set forEach: [ :value | result add: value ].
	^ result.
!

"Testing"

find: aValue
	"Return the object in the set that is (value)equal to the argument value, otherwise nil"
	self forEach: [ :value |
		value = aValue ifTrue: [ ^ value ] ].
	^ nil.
!
has: aValue
	"Not implemented with find:, because that cannot distinguish a nil value from not found.
	 The identity test in the JS set is fast, so it is done first."
	( Boolean fromJs: INLINE 'this.js.has( aValue )' ) ifTrue: [ ^ true ].
	self forEach: [ :value |
		value = aValue ifTrue: [ ^ true ] ].
	^ false.
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
