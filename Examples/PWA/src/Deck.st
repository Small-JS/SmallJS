CLASS Deck EXTENDS Object MODULE EmojiMemoryApp CLASSVARS ''
	VARS 'allCardFaces size cards'

"Var size is a Point holding the columns (x) and rows (y) of the game.
Var cards is a one dimensional array storing the columns per rows sequentially.
So the length of the cards array is columns * rows."

CLASSMETHODS

async initialize: aSize
	^ await self new initialize: aSize.
!

METHODS

"Initializing"

async initialize: aSize
	"Create new game with argument size (Point)."
	| pairCount face card |

	size := aSize.

	"Fetch all possible cards and randomize order."
	allCardFaces := await Fetch object: 'cards.json'.
	allCardFaces randomize.

	"Add pairs of all available cards to cards array."
	cards := Array new.
	pairCount := size x * size y // 2.
	0 to: pairCount - 1 do: [ :index |
		face := allCardFaces at: index.
		card := Card face: face.
		cards add: card; add: card copy ].

	"Randomize playing cards."
	cards randomize.

	"If number of cards is uneven, add an empty, turned card."
	size x * size y \\ 2 = 1 ifTrue: [
		cards add: Card empty ].
!

"Accessing"

allCardFaces
	^ allCardFaces.
!
cardAt: point
	^ cards at: point y * size x + point x.
!
size
	^ size.
!
cards
	^ cards.
!
length
	"Number of cards in the desk,
	not counting filler card to make it even."
	^ cards length // 2 * 2.
!
