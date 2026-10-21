CLASS MediaList EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class: MediaList.
	 It is a list of media queries, e.g. of a style sheet or an @import rule.
	 Get it with: StyleSheet media or CssImportRule media."

METHODS

"Properties"

length
	^ Integer fromJs: INLINE 'this.js.length'.
!
mediaText
	"Return the media queries as a comma separated String."
	^ String fromJs: INLINE 'this.js.mediaText'.
!
mediaText: mediaText
	INLINE 'this.js.mediaText = mediaText.js'.
!

"Methods"

item: index
	"Return the media query at the (zero-based) index, or nil if out of range."
	INLINE 'let jsItem = this.js.item( index.js )'.
	INLINE 'if( jsItem == null ) return stNil$'.
	^ String fromJs: INLINE 'jsItem'.
!
items
	"Return all media queries as an Array of Strings."
	^ Array fromJsStrings: INLINE 'Array.from( this.js )'.
!
appendMedium: medium
	"Add the medium to the end of the list, if not present yet."
	INLINE 'this.js.appendMedium( medium.js )'.
!
deleteMedium: medium
	"Remove the medium from the list. Throws a NotFoundError if not present."
	INLINE 'this.js.deleteMedium( medium.js )'.
!

"Converting"

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
