CLASS Text EXTENDS CharacterData MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class Text."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Text()'.
!
new: string
	^ self fromJs: INLINE 'new Text( string.js )'.
!

METHODS

"Properties."

assignedSlot
	^ HtmlSlotElement fromJs: INLINE 'this.js.assignedSlot'.
!
wholeText
	^ String fromJs: INLINE 'this.js.wholeText'.
!

"Methods."

splitText: offset
	^ Text fromJs: INLINE 'this.js.splitText( offset.js - 1 )'.
!
