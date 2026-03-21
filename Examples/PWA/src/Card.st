CLASS Card EXTENDS Object MODULE EmojiMemoryApp CLASSVARS ''
	VARS 'face turned'

"Var face is the emoji (single) character string of the card.
Var turned is a boolean indicating if the card has been turned face up."

CLASSMETHODS

"Creating"

face: face
	"Create a new card with argument face.
	The card is not turned by detault."
	^ self new face: face.
!
empty
	^ ( self face: 'X' ) turned: true.
!

METHODS

"Initializing"

constructor
	turned := false.
!

"Accessing"

face
	^ face.
!
back
	"Character string to display for unturned card"
	^ '🂠'.
!
face: aFace
	face := aFace.
!
turned
	^ turned.
!
turned: aTurned
	turned := aTurned.
!
display
	"Return display string for card,
	depending on turned status."
	^ turned
		ifTrue: [ self face ]
		ifFalse: [ self back ].
!

"Copying"

copy
	^ Card new
		face: self face;
		turned: self turned.
!
