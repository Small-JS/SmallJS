CLASS Array EXTENDS AbstractArray MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains a JS array."

CLASSMETHODS

"Creating"

new
	^ self basicNew js: INLINE '[]'.
!
new: length
	INLINE 'let array = new StArray(); array.js = Array.from( { length: length.js }, ( value, index ) => stNil ); return array'.
!
fromJs: jsArray elementClass: aClass
	"Create ST array from JS array, with ST elements of class aClass.
	 aClass must implement the fromJs: method."
	^ self fromJs: jsArray elementConverter:
		[ :jsObject | aClass fromJs: jsObject ].
!
fromJs: jsArray elementConverter: block
	"Create ST array from JS array, with ST elements renerated by block."
	| array |
	INLINE 'if( jsArray == null ) return stNil'.
	array := Array new.
	INLINE '
		for( let jsObject of jsArray )
			array.js.push( block.$value$( jsObject ) )'.
	^ array.
!
fromJsStrings: jsArray
	^ Array fromJs: jsArray elementClass: String.
!

"Testing"

isJsArray: jsArray
	^ Boolean fromJs: INLINE 'Array.isArray( jsArray )'.
!

METHODS

"Conversion"

toJs
	"Return JS array with JS representation of elements, that should be JsObject (sub)instances."
	INLINE '
		let array = [];
		for( let element of this.js )
			array.push( element.$toJs() );
		return array'.
!
copy
	^ self class fromJs: INLINE '[... this.js]'.
!

"Comparing."

= array
	( array isKindOf: Array ) ifFalse: [ ^ false ].
	self length = array length ifFalse: [ ^ false ].

	0 to: self length - 1 do: [ :index |
		( self at: index ) = ( array at: index  ) ifFalse: [ ^ false ] ].

	^ true.
!

"Accessing."

at: index
	( index < 0 ) | ( index >= self length ) ifTrue: [
		self error: 'Array index out of bounds.' ].

	^ INLINE 'this.js[ index.js ]'.
!
at: index put: value
	( index < 0 ) | ( index >= self length ) ifTrue: [
		self error: 'Array index out of bounds.' ].

	INLINE 'this.js[ index.js ] = value'.
!

"Add / remove."

, array
	^ self concat: array.
!
concat: array
	^ self class fromJs: INLINE 'this.js.concat( array.js )'.
!
add: value
	INLINE 'this.js.push( value )'.
!
pop
	self length = 0 ifTrue: [
		self error: 'Pop on empty array.' ].

	^ INLINE 'this.js.pop()'.
!

"Searching"

find: block
	^ Nil fromJs: INLINE 'this.js.find( ( element ) => block.js( element ).js )'.
!
includes: findElement
	^ ( self find: [ :element | element = findElement ] ) notNil.
!
findIndex: block
	^ Integer fromJs: INLINE 'this.js.findIndex( ( element ) => block.js( element ).js )'.
!
indexOf: findElement
	^ self findIndex: [ :element | element = findElement ].
!

"Iteration."

do: block
	self forEach: block.
!
forEach: block
	INLINE 'this.js.forEach( block.js )'.
!
every: block
	^ Boolean fromJs: INLINE 'this.js.every( ( element ) => block.js( element ).js )'.
!
some: block
	^ Boolean fromJs: INLINE 'this.js.some( ( element ) => block.js( element ).js )'.
!
filter: block
	^ self class fromJs: INLINE 'this.js.filter( ( element ) => block.js( element ).js )'.
!
map: block
	^ self class fromJs: INLINE 'this.js.map( block.js )'.
!
reduce: block
	^ INLINE 'this.js.reduce( block.js )'.
!
reduce: block with: value
	^ INLINE 'this.js.reduce( block.js, value )'.
!
reduceRight: block
	^ INLINE 'this.js.reduceRight( block.js )'.
!
reduceRight: block with: value
	^ INLINE 'this.js.reduceRight( block.js, value )'.
!

"Modification"

shift
	^ INLINE 'this.js.shift()'.
!
unshift: element
	INLINE 'this.js.unshift( element )'.
!
splice: start
	INLINE 'this.js.splice( start.js )'.
!
splice: start count: count
	INLINE 'this.js.splice( start.js, count.js )'.
!
removeAt: index
	self splice: index count: 1
!

"Sorting."

sort
	"Sort self in-place."
	self sortWith: [ :a :b | a compare: b ].
!
sortWith: compareBlock
	"Sort self in-place using a 2-arg compareBlock
	 that should return -1, 0, 1 when arg1 is smaller, equal to, or greater than arg2, respectively."

	| jsCompareBlock |
	"Need helper block to convert ST compare values to JS."
	jsCompareBlock := [ :a :b | ( compareBlock value: a value: b ) js ].
	INLINE 'this.js.sort( jsCompareBlock.js )'.
!
