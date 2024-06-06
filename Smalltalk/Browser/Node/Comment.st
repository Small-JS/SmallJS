CLASS Comment EXTENDS CharacterData MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS abstract class CharacterData."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Comment()'.
!
new: string
	^ self fromJs: INLINE 'new Comment( string.js )'.
!

METHODS

"No additional properties or methods."
