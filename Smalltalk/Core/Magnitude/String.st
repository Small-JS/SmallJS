CLASS String EXTENDS Magnitude MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains a JS string."

CLASSMETHODS

new
	^ self basicNew js: INLINE '""'.
!
fromCharacter: character
	^ self fromJs: INLINE 'String.fromCharCode( character.js )'.
!
fromCharCode: code
	^ self fromJs: INLINE 'String.fromCharCode( code.js )'.
!
newline
	^ self fromCharacter: Character newline.
!

METHODS

"Conversion."

toString
	^ self.
!
toInteger
	^ Integer fromJs: INLINE 'parseInt( this.js )'.
!
toFloat
	^ Float fromJs: INLINE 'parseFloat( this.js )'.
!

"Accessing."

length
	^ Integer fromJs: INLINE 'this.js.length'.
!
at: index
	( index < 0 ) | ( index >= self length ) ifTrue: [
		self error: 'String index out of bounds.' ].

	^ Character fromJs: INLINE 'this.js.charCodeAt( index.js )'.
!
at: index put: character
	( index < 0 ) | ( index >= self length ) ifTrue: [
		self error: 'String index out of bounds.' ].

	INLINE 'this.js = this.js.substring( 0, index.js ) + String.fromCharCode( character.js ) + this.js.substring( index.js + 1, this.js.length )'.
!

"Searching."

includes: string
	^ Boolean fromJs: INLINE 'this.js.includes( string.js )'.
!
includes: string from: index
	^ Boolean fromJs: INLINE 'this.js.includes( string.js, index.js )'.
!
startsWith: string
	^ Boolean fromJs: INLINE 'this.js.startsWith( string.js )'.
!
endsWith: string
	^ Boolean fromJs: INLINE 'this.js.endsWith( string.js )'.
!
indexOf: string
	^ Integer fromJs: INLINE 'this.js.indexOf( string.js )'.
!
indexOf: string from: index
	^ Integer fromJs: INLINE 'this.js.indexOf( string.js, index.js )'.
!
lastIndexOf: string
	^ Integer fromJs: INLINE 'this.js.lastIndexOf( string.js )'.
!
lastIndexOf: string from: index
	^ Integer fromJs: INLINE 'this.js.lastIndexOf( string.js, index.js )'.
!

match: regexp flags: flags
	INLINE '
		let result = this.js.match( new RegExp( regexp.js, flags.js ) );
		if( result == null )
			return stNil;
		return stArray$class.$fromJs$elementClass$( result, stString$class )'.
!
search: regexp
	^ Integer fromJs: INLINE 'this.js.search( new RegExp( regexp.js ) )'.
!

"Comparisons."

= string
	^ Boolean fromJs: INLINE 'this.js == string.js'.
!
< string
	^ Boolean fromJs: INLINE 'this.js < string.js'.
!
<= string
	^ Boolean fromJs: INLINE 'this.js <= string.js'.
!
> string
	^ Boolean fromJs: INLINE 'this.js > string.js'.
!
>= string
	^ Boolean fromJs: INLINE 'this.js >= string.js'.
!
localeCompare: string
	^ Integer fromJs: INLINE 'this.js.localeCompare( string.js )'.
!

"Manipulation."

+ string
	^ String fromJs: INLINE 'this.js + string.js'.
!
, string
	^ self + string.
!
substring: start
	^ String fromJs: INLINE 'this.js.substring( start.js )'.
!
substring: start to: end
	^ String fromJs: INLINE 'this.js.substring( start.js, end.js )'.
!
slice: start
	^ String fromJs: INLINE 'this.js.slice( start.js )'.
!
slice: start to: end
	^ String fromJs: INLINE 'this.js.slice( start.js, end.js )'.
!
split: separator
	^ Array fromJs: INLINE 'this.js.split( separator.js )' elementClass: String.
!
padEnd: length
	^ String fromJs: INLINE 'this.js.padEnd( length.js )'.
!
padEnd: length with: string
	^ String fromJs: INLINE 'this.js.padEnd( length.js, string.js )'.
!
padStart: length
	^ String fromJs: INLINE 'this.js.padStart( length.js )'.
!
padStart: length with: string
	^ String fromJs: INLINE 'this.js.padStart( length.js, string.js )'.
!
repeat: count
	^ String fromJs: INLINE 'this.js.repeat( count.js )'.
!
replace: search with: replace
	^ String fromJs: INLINE 'this.js.replace( search.js, replace.js )'.
!
replaceAll: search with: replace
	^ String fromJs: INLINE 'this.js.replaceAll( search.js, replace.js )'.
!
trim
	^ String fromJs: INLINE 'this.js.trim()'.
!
trimStart
	^ String fromJs: INLINE 'this.js.trimStart()'.
!
trimEnd
	^ String fromJs: INLINE 'this.js.trimEnd()'.
!

"Case."

toUpperCase
	^ String fromJs: INLINE 'this.js.toUpperCase()'.
!
toLocaleUpperCase
	^ String fromJs: INLINE 'this.js.toLocaleUpperCase()'.
!
toLowerCase
	^ String fromJs: INLINE 'this.js.toLowerCase()'.
!
toLocaleLowerCase
	^ String fromJs: INLINE 'this.js.toLocaleLowerCase()'.
!

"Iteration."

do: block
	INLINE '
		for( let $char of this.js ) {
			block.$value$( stCharacter$class.$fromJs$( $char.charCodeAt( 0 ) ) ) }'.
!
