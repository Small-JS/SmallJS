CLASS EventId EXTENDS Object MODULE DOM CLASSVARS '' VARS 'type block jsBlock'
	"Implement an association between ST and JS event blocks,
	 needed when removing event listeners."

CLASSMETHODS

fromType: type block: block jsBlock: jsBlock
	^ self new type: type; block: block; jsBlock: jsBlock.
!

METHODS

"Properties."

type
	^ type.
!
type: aType
	type := aType.
!
block
	^ block.
!
block: aBlock
	block := aBlock.
!
jsBlock
	^ jsBlock.
!
jsBlock: aJsBlock
	jsBlock := aJsBlock.
!
