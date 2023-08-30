CLASS AbstractArray EXTENDS Collection MODULE Core CLASSVARS '' VARS ''
	"This abstract class contains the common functionality of classes Array and TypedArray."

CLASSMETHODS

with: element
	^ ( self new: 1 ) at: 0 put: element.
!
with: element1 with: element2
	^ ( self new: 2 ) at: 0 put: element1 ; at: 1 put: element2.
!

METHODS

"Conversion"

copy
	^ self class fromJs: INLINE 'this.js.slice()'.
!
toString
	^ '#( ', ( self join: ' ' ), ' )'.
!
toLocaleString
	^ '#( ', ( self join: ' ' toStringConverter: [ :element | element toLocaleString ] ), ' )'.
!
join: separator
	^ self join: separator toStringConverter: [ :element | element toString ].
!
join: separator toStringConverter: block
	| string first |
	string := ''.
	first := true.
	self do: [ :element |
		first ifTrue: [ first := false ] ifFalse: [ string := string + separator ].
		string := string + ( block value: element ) ].
	^ string.
!
entries
	| result |
	result := Array new: self length.
	0 to: self length - 1 do: [ :index |
		result at: index put: ( Array with: index with: ( self at: index ) ) ].
	^ result.
!

"Accessing"

length
	^ Integer fromJs: INLINE 'this.js.length'.
!
first
	^ self at: 0.
!
last
	^ self at: self length - 1.
!

"Modification"

copyWithin: target start: start end: end
	INLINE 'this.js.copyWithin( target.js, start.js, end.js )'.
!
fill: value start: start end: end
	INLINE 'this.js.fill( value.js, start.js, end.js )'.
!
slice: start
	^ self class fromJs: INLINE 'this.js.slice( start.js )'.
!
slice: start to: end
	^ self class fromJs: INLINE 'this.js.slice( start.js, end.js )'.
!
reverse
	INLINE 'this.js.reverse()'.
!
swap: index1 with: index2
	| temp |
	temp := self at: index1.
	self at: index1 put: ( self at: index2 ).
	self at: index2 put: temp.
!

"Selection"

subarray: start
	^ self class fromJs: INLINE 'this.js.subarray( start.js )'.
!
subarray: start to: end
	^ self class fromJs: INLINE 'this.js.subarray( start.js, end.js )'.
!
