CLASS DomTokenList EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: DOMTokenList.
	 Note: Item indexes and keys in this class are zero based."

CLASSMETHODS

new
	self error: 'DomTokenList cannot be created with new.'.
!

METHODS

"Properties."

length
	^ Integer fromJs: INLINE 'this.js.length'.
!
value
	^ String fromJs: INLINE 'this.js.value'.
!
value: value
	INLINE 'this.js.value = value.js'.
!

"Methods."

add: token
	INLINE 'this.js.add( token.js )'.
!
contains: token
	^ Boolean fromJs: INLINE 'this.js.contains( token.js )'.
!
entries
	"Return an Array of pairs: Arrays with the (zero-based) index and the token."
	^ Array fromJs: INLINE 'this.js.entries()' elementConverter:
		[ :jsEntry | Array with: ( Integer fromJs: INLINE 'jsEntry[ 0 ]' ) with: ( String fromJs: INLINE 'jsEntry[ 1 ]' ) ].
!
item: index
	^ String fromJs: INLINE 'this.js.item( index.js )'.
!
keys
	^ Array fromJs: INLINE 'this.js.keys()' elementClass: Integer.
!
remove: token
	INLINE 'this.js.remove( token.js )'.
!
replace: oldToken with: newToken
	INLINE 'this.js.replace( oldToken.js, newToken.js )'.
!
supports: token
	^ Boolean fromJs: INLINE 'this.js.supports( token.js )'.
!
toggle: token
	^ Boolean fromJs: INLINE 'this.js.toggle( token.js )'.
!
values
	^ Array fromJs: INLINE 'this.js.values()' elementClass: String.
!
