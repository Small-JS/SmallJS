CLASS TypedArray EXTENDS AbstractArray MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

from: array
	| result |
	result := self new: array length.

	0 to: array length - 1 do: [ :index |
		result at: index put: ( array at: index ) ].

	^ result.
!

METHODS

"Conversion"

toArray
	^ Array fromJs: INLINE 'Array.from( this.js )' elementClass: self elementClass.
!
elementClass
	^ self class elementClass.
!

"Buffer"

buffer
	^ ArrayBuffer fromJs: INLINE 'this.js.buffer'.
!
byteLength
	^ Integer fromJs: INLINE 'this.js.byteLength'.
!
byteOffset
	^ Integer fromJs: INLINE 'this.js.byteOffset'.
!

"Accessing"

at: index
	( index < 0 ) | ( index >= self length ) ifTrue: [
		self error: 'Array index out of bounds.' ].

	^ self elementClass fromJs: INLINE 'this.js.at( index.js )'.
!
at: index put: value
	( index < 0 ) | ( index >= self length ) ifTrue: [
		self error: 'Array index out of bounds.' ].

	INLINE 'this.js[ index.js ] = value.js'.
!
set: typedArray offset: offset
	INLINE 'this.js.set( typedArray.js, offset.js )'.
!

"Searching"

find: block
	^ self elementClass fromJs: INLINE 'this.js.find( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
findLast: block
	^ self elementClass fromJs: INLINE 'this.js.findLast( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
includes: element
	^ Boolean fromJs: INLINE 'this.js.includes( element.js )'.
!
findIndex: block
	^ Integer fromJs: INLINE 'this.js.findIndex( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
findLastIndex: block
	^ Integer fromJs: INLINE 'this.js.findLastIndex( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
indexOf: element
	^ Integer fromJs: INLINE 'this.js.indexOf( element.js )'.
!
lastIndexOf: element
	^ Integer fromJs: INLINE 'this.js.lastIndexOf( element.js )'.
!

"Iteration"

do: block
	self forEach: block.
!
forEach: block
	INLINE 'this.js.forEach( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ) )'.
!
every: block
	^ Boolean fromJs: INLINE 'this.js.every( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
some: block
	^ Boolean fromJs: INLINE 'this.js.some( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
filter: block
	^ self class fromJs: INLINE 'this.js.filter( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
map: block
	^ self class fromJs: INLINE 'this.js.map(
		( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js )'.
!
reduce: block
	^ self elementClass fromJs: INLINE 'this.js.reduce(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js )'.
!
reduce: block with: value
	^ self elementClass fromJs: INLINE 'this.js.reduce(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js,
		value.js )'.
!
reduceRight: block
	^ self elementClass fromJs: INLINE 'this.js.reduceRight(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js )'.
!
reduceRight: block with: value
	^ self elementClass fromJs: INLINE 'this.js.reduceRight(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js,
		value.js )'.
!
